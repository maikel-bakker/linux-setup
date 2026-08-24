# 0012: Use Rofi for application launching

**Status:** Accepted
**Date:** 2026-08-24

## Context

Fuzzel provided a small native Wayland launcher for the initial session. Rofi
offers a richer interface, application and window modes, extensive Rasi theming,
and a larger customization ecosystem. Rofi 2.0 has merged native Wayland support
into its mainline release, and Arch's repository package provides that version.

## Decision

Replace Fuzzel with the official Arch `rofi` package. Bind `Super+Space` to
`rofi -show drun`, manage an explicit Catppuccin Mocha Rasi configuration, and
retain Kitty as the terminal used by Rofi's run modes.

## Consequences

- Fresh installations install Rofi directly and do not install Fuzzel first.
- The launcher supports application, command, and window-switching modes.
- Rofi's configuration is more flexible but more extensive than Fuzzel's.
- Existing lab installations should remove Fuzzel after Rofi is validated.
