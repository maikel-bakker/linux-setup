# 0007: Use Hyprland with Kitty for the first graphical session

**Status:** Accepted
**Date:** 2026-07-28

## Context

The desktop should support dynamic tiling, attractive theming, and scripted
task-oriented workspaces. Sway offers more direct container-tree control, but
Hyprland's appearance, animations, rules, and automation are a better match for
the desired daily experience. The terminal should integrate well with Wayland
and offer richer built-in features than a strictly minimal terminal.

## Decision

Use Hyprland as the first Wayland compositor and Kitty as its terminal. Assemble
the remaining session from small explicit components rather than adopting a
preconfigured desktop bundle. Start Hyprland manually from a TTY until the
session is validated; defer the display-manager decision.

## Consequences

- The desktop gains dynamic tiling and extensive appearance controls.
- Kitty provides tabs, splits, image support, and remote control at a modest
  complexity cost compared with Foot.
- Bars, notifications, portals, locking, and other desktop functions remain
  visible, independently managed components.
- Hyprland configuration changes more quickly than conservative compositors, so
  upgrades may require deliberate configuration migrations.
- Exact reusable development layouts will rely on Hyprland rules and scripts
  rather than Sway-style placeholder container trees.
