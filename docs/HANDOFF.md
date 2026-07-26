# Current handoff: Arch lab

Read this file first when continuing the project in a new Codex session.

## Goal

Develop an understandable, intentionally minimal, reproducible Arch Linux daily-driver setup for web development and gaming. Validate the design in the `arch-lab` VM before changing the physical host.

## Source of truth

- Repository: `git@github.com:maikel-bakker/linux-setup.git`
- Physical host checkout: `/home/mb/Projects/linux-setup`
- VM checkout: `~/Projects/linux-setup`
- The repository is the design/rebuild source of truth; snapshots and VM disks are rollback aids, not configuration sources.

## Lab status

`arch-lab` is a working UEFI Arch VM. It boots through systemd-boot, prompts for the LUKS2 passphrase, mounts Btrfs subvolumes, and supports SSH login as `mb`.

Implemented inside the VM:

- LUKS2 root with Btrfs subvolumes and systemd-boot: see `docs/02-storage-and-boot.md`.
- NetworkManager, systemd-resolved, SSH, `sudo`, user `mb`, and root SSH login disabled.
- zram swap and systemd-timesyncd: see `docs/03-core-services.md`.
- Zsh, pinned Oh My Zsh, and pinned zsh-autosuggestions: see `docs/04-zsh.md`.
- Node.js/npm manifest and user-local global npm tooling: see `docs/05-web-development.md`.

## Host networking prerequisite

The physical host runs UFW with default-deny input/forward policy. The VM network only works with the documented `virbr0` DNS/DHCP and forward rules in `docs/01-host-and-lab.md`. Do not remove them without replacing their function.

## Current next action

Codex CLI is installed in the VM with API-key authentication. Its resolver
requires the standard `/etc/resolv.conf` link; the working VM configuration is
now represented by `scripts/configure-systemd-resolved` and documented in
`docs/03-core-services.md`.

On a rebuild, install the CLI and configure DNS before using Codex:

```sh
cd ~/Projects/linux-setup
git pull
./scripts/install-global-npm-packages npm/global-packages.txt
sudo ./scripts/configure-systemd-resolved
exec zsh -l
codex --version
codex doctor --summary
```

Authentication is interactive and API keys must never be committed. The npm script installs into `~/.local`; the managed Zsh config adds `~/.local/bin` to `PATH`.

## How to continue

Start Codex from the VM repository and say:

> Read `docs/HANDOFF.md`, then `README.md` and the relevant numbered document. Continue the Arch lab layer by layer, update the docs/decision records/package manifests/scripts first, and keep secrets out of Git.

## Deferred decisions

- Terminal emulator and graphical desktop/compositor/window-manager evaluation.
- Persisted workspace/layout/session workflow for Hyprland alternatives.
- Secure Boot, TPM unlocking, snapshots/backup tooling, and GPU passthrough.
- AUR workflow, Zed installation, and additional development tooling.
