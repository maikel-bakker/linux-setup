# 0008: Use Catppuccin Mocha as the baseline desktop palette

**Status:** Accepted
**Date:** 2026-07-29

## Context

The first graphical session works but uses unrelated application defaults, and
Waybar's packaged demonstration configuration crashes when its incomplete power
menu is opened. The desktop needs a coherent theme and a repository-managed bar
before more applications are evaluated.

## Decision

Use the official Catppuccin Mocha color palette across Hyprland, Waybar, Kitty,
Fuzzel, and Mako. Keep each local configuration explicit instead of installing
third-party theme bundles. Run Waybar as a restartable systemd user service and
omit power controls until a safe confirmation workflow is designed.

## Consequences

- The core session has one recognizable palette with mauve as its main accent.
- Theme behavior remains inspectable in this repository.
- Upstream theme ports are not updated automatically; palette changes are
  deliberate repository changes.
- Waybar recovers from crashes, but logout/shutdown actions are temporarily
  absent from the bar.
- A wallpaper remains a separate visual and licensing decision.
