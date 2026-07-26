# Storage, encryption, and boot

This is the reference layout for the Arch lab and the intended starting point for the physical system. Substitute real device names and UUIDs during an installation; do not commit passphrases or machine-specific encryption material.

## Layout

```text
GPT disk
├── EFI System Partition, 1 GiB, FAT32, mounted at /boot
└── LUKS2 container, remaining space
    └── Btrfs filesystem (label: archroot)
        ├── @          mounted at /
        ├── @home      mounted at /home
        ├── @log       mounted at /var/log
        ├── @pkg       mounted at /var/cache/pacman/pkg
        └── @snapshots mounted at /.snapshots
```

## Mount policy

All Btrfs subvolumes use `noatime,compress=zstd:3`. The EFI System Partition remains unencrypted because UEFI firmware must read the bootloader and kernel images before Linux can unlock the LUKS container.

## Boot contract

- Firmware: UEFI.
- Bootloader: systemd-boot, installed to the EFI System Partition.
- Initramfs: mkinitcpio using the `systemd` and `sd-encrypt` hooks.
- Kernel command line: `rd.luks.name=<LUKS_UUID>=cryptroot root=/dev/mapper/cryptroot rootflags=subvol=@ rw`.

`cryptroot` is the stable mapper name used by both the initramfs and `fstab`.

## Minimal base packages

```text
base linux linux-firmware amd-ucode btrfs-progs cryptsetup
```

`NetworkManager`, `openssh`, and `sudo` are the deliberately minimal post-bootstrap packages needed for persistent network access, administration, and remote operation in the lab.

## Keyring bootstrap note

On the July 2026 Arch ISO, `pacstrap` initially failed because the live ISO keyring had not been initialized. If signature verification reports that the keyring is not writable, initialize the **live installer** keyring, then update `archlinux-keyring` before retrying `pacstrap`:

```sh
pacman-key --init
pacman-key --populate archlinux
pacman -Sy --needed archlinux-keyring
```

## First installed user

The lab uses the non-root user `mb`, in the `wheel` group, with a Bash shell. Passworded root SSH login is not enabled. Remote administration uses `mb` plus `sudo`.
