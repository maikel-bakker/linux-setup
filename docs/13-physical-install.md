# Physical installation runbook

## Status and scope

This is a reviewable plan for the first physical installation. It has **not**
yet been executed. The intended target is the disk that currently contains
Windows; the current Arch system remains a separate, untouched fallback.

This runbook intentionally does not automate partitioning or encryption. Those
steps are where explicit device verification matters most. It reuses the
storage and boot design in `docs/02-storage-and-boot.md` after the target is
confirmed.

## Safety boundary

The target disk will be destroyed. Do not proceed until Windows files, browser
profiles, game saves, licenses, BitLocker recovery material, and any other
wanted data have been backed up or consciously discarded.

Before booting the installer, verify that this repository is pushed and that
the current Arch disk can still boot independently. The strongest safeguard is
to temporarily disconnect the current Arch drive during installation, but only
if you can positively identify the physical drives. Otherwise leave both drives
connected and use the target-verification gate below.

## Target-verification gate

Boot a current Arch ISO in UEFI mode. Before any format command, inspect every
disk:

```sh
lsblk --paths -o NAME,SIZE,MODEL,SERIAL,FSTYPE,PARTLABEL,MOUNTPOINTS
```

The target must be the disk that previously held Windows. On the current host,
it is recognizable by its Windows-style layout: a small FAT EFI partition, a
16 MiB Microsoft-reserved partition, a large NTFS partition, and an NTFS
recovery partition. The existing Arch fallback instead contains an EFI
partition followed by a LUKS partition. Device names can change in the ISO;
never select a disk from its `nvme0`/`nvme1` name alone.

Write the verified target path below only for the current installer session:

```sh
target_disk=/dev/nvmeXn1
```

Stop if the target is not unambiguous.

## Disk, encryption, and Btrfs

The commands below intentionally erase only `"$target_disk"`. Re-read the
variable and the `lsblk` output immediately before running them.

```sh
sgdisk --zap-all "$target_disk"
sgdisk -n 1:0:+1GiB -t 1:ef00 -c 1:EFI "$target_disk"
sgdisk -n 2:0:0 -t 2:8309 -c 2:cryptroot "$target_disk"

cryptsetup luksFormat "${target_disk}p2"
cryptsetup open "${target_disk}p2" cryptroot
mkfs.btrfs -L archroot /dev/mapper/cryptroot

mount /dev/mapper/cryptroot /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@pkg
btrfs subvolume create /mnt/@snapshots
umount /mnt

mount -o subvol=@,noatime,compress=zstd:3 /dev/mapper/cryptroot /mnt
mkdir -p /mnt/{boot,home,var/log,var/cache/pacman/pkg,.snapshots}
mount -o subvol=@home,noatime,compress=zstd:3 /dev/mapper/cryptroot /mnt/home
mount -o subvol=@log,noatime,compress=zstd:3 /dev/mapper/cryptroot /mnt/var/log
mount -o subvol=@pkg,noatime,compress=zstd:3 /dev/mapper/cryptroot /mnt/var/cache/pacman/pkg
mount -o subvol=@snapshots,noatime,compress=zstd:3 /dev/mapper/cryptroot /mnt/.snapshots

mkfs.fat -F 32 -n EFI "${target_disk}p1"
mount -t vfat "${target_disk}p1" /mnt/boot
findmnt -R /mnt
```

The partition suffix is `p1`/`p2` because this runbook targets an NVMe disk.
For a SATA disk, use the appropriate partition path syntax instead.

## Bootstrap and base configuration

Confirm internet access with both an address and a DNS name. If the ISO has a
keyring error, follow the keyring bootstrap note in `docs/02-storage-and-boot.md`.

```sh
pacstrap -K /mnt base linux linux-firmware amd-ucode btrfs-progs cryptsetup
genfstab -U /mnt > /mnt/etc/fstab
arch-chroot /mnt
```

Inside the chroot, configure the locale, time zone, hostname, and passwords.
The current intended values are `en_US.UTF-8`, `America/Chicago`, `arch-linux`,
and user `mb`; choose a new unique hostname if preferred.

Add `sd-encrypt` between `block` and `filesystems` in `/etc/mkinitcpio.conf`:

```text
HOOKS=(base systemd autodetect microcode modconf kms keyboard sd-vconsole block sd-encrypt filesystems fsck)
```

Inside the chroot, identify the already-verified encrypted partition by its
actual path (the live-shell `target_disk` variable is not available here),
obtain its LUKS UUID, rebuild the initramfs, and install systemd-boot:

```sh
cryptsetup luksUUID /dev/nvmeXn1p2
mkinitcpio -P
bootctl install
```

Create `/boot/loader/loader.conf` with `default arch.conf`, `timeout 3`, and
`editor no`. Create `/boot/loader/entries/arch.conf` with this contract,
substituting the UUID printed above:

```text
title   Arch Linux
linux   /vmlinuz-linux
initrd  /amd-ucode.img
initrd  /initramfs-linux.img
options rd.luks.name=<LUKS_UUID>=cryptroot root=/dev/mapper/cryptroot rootflags=subvol=@ rw
```

Install and enable the minimum services before rebooting:

```sh
pacman -S --needed git networkmanager openssh sudo zram-generator
systemctl enable NetworkManager systemd-resolved sshd
ln -sfn /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
```

Create `mb`, add it to `wheel`, set its password, and configure sudo using
`visudo`. Do not enable root SSH access. Then leave the chroot and reboot.

## First real-hardware boot

Choose the new drive through firmware's one-time boot menu. It should prompt
for the LUKS passphrase and then boot to a TTY. Log in as `mb`, confirm network
access, and clone the repository using an authenticated method. Do not copy a
private SSH key into Git; create a new machine-specific key if SSH Git access
is wanted.

Run the managed setup in layers:

```sh
sudo ./scripts/configure-systemd-resolved
sudo ./scripts/install-packages packages/20-shell.txt packages/30-web-development.txt
./scripts/install-zsh-framework
./scripts/apply-zsh-config
sudo ./scripts/configure-shell mb

sudo ./scripts/install-packages packages/40-graphical-base.txt packages/41-hyprland-session.txt
./scripts/apply-hyprland-config
./scripts/apply-desktop-theme
./scripts/apply-lock-config

sudo ./scripts/install-packages packages/43-zed-editor.txt packages/physical/43-amd-vulkan.txt
./scripts/apply-zed-config
```

Install Firefox and the remaining browser/AUR layer only after the base desktop
works. Install global npm tools and authenticate Codex locally; neither API
keys nor credentials belong in the repository.

## Acceptance checks

Before treating the physical install as daily-driver ready, verify:

```sh
findmnt -R /
systemctl is-active NetworkManager systemd-resolved sshd
resolvectl query archlinux.org
getent ahostsv4 api.openai.com
vulkaninfo --summary
vkcube-wayland
```

Launch Hyprland, then verify audio, both monitors, the lock/unlock path,
Waybar, Rofi, Firefox, Zed, and the integrated terminal. Zed must use the AMD
Vulkan renderer without the VM's llvmpipe warning.

## Rollback

If any physical-install step fails, select the current Arch drive in firmware's
one-time boot menu. It remains independent because no partitions or boot files
on that disk are changed by this runbook.

Do not erase or repurpose the fallback drive until backups and recovery policy
are designed and tested.
