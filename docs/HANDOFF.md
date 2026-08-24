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
- The compositor-independent Mesa, PipeWire/WirePlumber, RealtimeKit, and font
  foundation is installed and its SSH-visible service graph is validated: see
  `docs/06-graphical-foundation.md`.
- Hyprland with Kitty and its supporting session components are installed. The
  managed minimal Lua configuration passes Hyprland's config parser, and the
  first graphical launch is working with portals and Virtio audio: see
  `docs/07-hyprland-session.md`.
- The Catppuccin Mocha configurations are applied. The Hyprland-specific Waybar
  is running as a crash-resistant user service: see `docs/08-desktop-theme.md`.
- The managed Waybar configuration is now adapted from the MIT-licensed Athena
  design. Its Nerd Font glyphs, drawers, and controls are working in the lab.
- Hyprlock authentication is validated, Hypridle is enabled and active with the
  managed five-minute lock and ten-minute display timeout rules, and `Super+L`
  is configured: see `docs/09-session-locking.md`.

## Host networking prerequisite

The physical host runs UFW with default-deny input/forward policy. The VM network only works with the documented `virbr0` DNS/DHCP and forward rules in `docs/01-host-and-lab.md`. Do not remove them without replacing their function.

## Current next action

Verify the live `Super+L` binding and the Waybar idle-inhibitor toggle. Then
choose the next graphical sublayer: automatic session startup or the first
development applications/workspace workflow. Wallpaper generation was
unavailable and is deferred. Theme switching and safe power controls remain
later sublayers. Authentication remains interactive, and API keys must never be
committed.

## How to continue

Start Codex from the VM repository and say:

> Read `docs/HANDOFF.md`, then `README.md` and the relevant numbered document. Continue the Arch lab layer by layer, update the docs/decision records/package manifests/scripts first, and keep secrets out of Git.

## Deferred decisions

- Display manager versus TTY session startup.
- Hyprland wallpaper, theme switching, and persisted workspace/layout workflow.
- Secure Boot, TPM unlocking, snapshots/backup tooling, and GPU passthrough.
- AUR workflow, Zed installation, and additional development tooling.
