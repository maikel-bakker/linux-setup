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
- Node.js/npm and the npm-installed Codex CLI are validated with a user-local
  `~/.local` prefix: see `docs/05-web-development.md` and decision record 0014.
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
- Nautilus replaces Thunar as the selected graphical file manager and is bound
  to `Super+F`: see decision record 0011.
- Rofi 2.0 replaces Fuzzel as the native Wayland application launcher on
  `Super+Space`, with a managed Catppuccin Mocha theme: see decision record 0012.
- Firefox and Google Chrome are selected as the browser layer. Chrome uses a
  review-first AUR workflow rather than an automatic helper: see
  `docs/10-browsers.md` and decision record 0013.
- Zed is selected from Arch's official repository, with the lab-specific
  `vulkan-virtio` provider separated from the portable editor manifest: see
  `docs/11-zed-editor.md` and decision record 0015.
- Zed package installation and Rofi discovery are validated. Its renderer falls
  back to llvmpipe because the VM does not expose accelerated Vulkan; native Zed
  rendering remains a required physical-host test with `vulkan-radeon`.
- A repository-native, Rofi-fronted theme switcher applies Catppuccin Mocha and
  Latte across the selected desktop components and is live-validated: see
  `docs/12-theme-switching.md` and decision record 0017.
- The repository-owned Desert Catppuccin wallpaper is assigned to Mocha through
  Hyprpaper and the active theme is restored when Hyprland starts. Hyprpaper is
  skipped in VMs after its QEMU GBM allocation failure; native rendering remains
  a physical-host validation item.

## Host networking prerequisite

The physical host runs UFW with default-deny input/forward policy. The VM network only works with the documented `virbr0` DNS/DHCP and forward rules in `docs/01-host-and-lab.md`. Do not remove them without replacing their function.

## Current next action

Review `docs/13-physical-install.md` before making the first real-hardware
installation. It targets the former Windows disk while retaining the current
Arch disk as a fallback and adds a physical-only Radeon Vulkan manifest. Build
the first development workspace workflow after the physical base is working.
Gaming, snapshots/backups, and power actions beyond the Rofi lock, sleep,
logout, restart, and confirmed poweroff controls remain later sublayers.
Hyprland now starts after an interactive `tty1` login; authentication remains
interactive, and API keys must never be committed.

## How to continue

Start Codex from the VM repository and say:

> Read `docs/HANDOFF.md`, then `README.md` and the relevant numbered document. Continue the Arch lab layer by layer, update the docs/decision records/package manifests/scripts first, and keep secrets out of Git.

## Deferred decisions

- Display manager versus TTY session startup.
- Persisted workspace/layout workflow.
- Secure Boot, TPM unlocking, snapshots/backup tooling, and GPU passthrough.
- Additional development tooling and Zed configuration.
