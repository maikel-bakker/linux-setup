# 0021: Start Hyprland after TTY login

**Status:** Accepted
**Date:** 2026-08-29

## Context

The physical graphical session is working and should become the normal desktop
after boot. Automatic login would remove an authentication boundary, while a
display manager adds another graphical component and duplicates the existing
TTY login. Hyprland provides `start-hyprland` as its supported watchdog wrapper.

## Decision

Keep the normal interactive TTY login and start `start-hyprland` from the
managed Zsh login profile only when logging in locally on `tty1` with no display
session already present. Do not affect SSH or secondary TTYs.

## Consequences

- A successful `tty1` login enters Hyprland without a second command.
- Boot still requires the user's normal login credentials.
- SSH and secondary TTYs remain non-graphical recovery paths.
- Logging out of Hyprland returns to the `tty1` login prompt.
- A display manager can be reconsidered later if session selection or a
  graphical greeter becomes valuable.
