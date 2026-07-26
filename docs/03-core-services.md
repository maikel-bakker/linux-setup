# Core services and maintenance

## zram swap

Use `zram-generator` instead of a disk-backed swap partition. Hibernation is intentionally unsupported.

`/etc/systemd/zram-generator.conf`:

```ini
[zram0]
zram-size = min(ram / 2, 8192)
compression-algorithm = zstd
swap-priority = 100
```

This yields about 4 GiB of compressed swap in the 8 GiB VM and caps the physical 32 GiB host at 8 GiB. The generator creates the swap device at boot; verify it with `swapon --show` and `zramctl`.

## Time

Use `systemd-timesyncd` for NTP synchronization:

```sh
sudo systemctl enable --now systemd-timesyncd
timedatectl show -p Timezone -p NTPService -p NTPSynchronized
```

`NTPSynchronized=no` immediately after enabling is normal; it becomes `yes` once a time source responds.

## SSH

SSH is enabled for the normal administrator account, `mb`. Root SSH login is explicitly disabled in `/etc/ssh/sshd_config.d/10-local-hardening.conf`:

```text
PermitRootLogin no
KbdInteractiveAuthentication no
```

Keep password authentication enabled until a separate SSH-key decision is made. Validate any SSH change with `sshd -t` before reloading the service.

## Updates

Use manual, full system upgrades:

```sh
sudo pacman -Syu
```

Do not run partial upgrades such as `pacman -Sy` followed by arbitrary package installs. Automatic background upgrades are intentionally deferred; review upgrades and snapshot policy together in the backup/recovery layer.
