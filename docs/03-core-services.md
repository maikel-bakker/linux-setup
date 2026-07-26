# Core services and maintenance

## DNS resolution

Use `systemd-resolved` as the system resolver, with NetworkManager supplying
the per-network DNS servers. `resolvectl` can work even when ordinary programs
cannot resolve names, so `/etc/resolv.conf` must be a symlink to the local
resolver stub rather than an empty regular file.

Apply the reproducible configuration:

```sh
sudo ./scripts/configure-systemd-resolved
```

This enables `systemd-resolved` and links `/etc/resolv.conf` to
`/run/systemd/resolve/stub-resolv.conf`. The file will therefore contain
`nameserver 127.0.0.53`; use `resolvectl status` to see the real DNS server
that NetworkManager received for the active connection.

Verify both resolver interfaces after configuration:

```sh
resolvectl query archlinux.org
getent ahostsv4 archlinux.org
```

The first talks directly to `systemd-resolved`; the second exercises the
standard resolver interface used by most applications. This distinction caught
an empty `/etc/resolv.conf` in the VM: `resolvectl` succeeded but Codex failed
with a temporary DNS lookup error.

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
