# 0019: Confirm power actions with Rofi

**Status:** Accepted
**Date:** 2026-08-29

## Context

The graphical session needs convenient lock, sleep, logout, restart, and
shutdown paths, but direct keybindings to destructive session actions would
make accidental data loss too easy. Rofi is already the selected launcher and
follows the active desktop palette.

## Decision

Bind `Super+Escape` to a repository-managed Rofi power menu. Display
**Power off**, **Lock**, **Restart**, **Sleep**, **Log out**, and **Cancel** in
that order, with **Power off** preselected. Reject custom menu input and allow
Escape to dismiss the menu. Use the duplicate-safe Hyprlock command,
`systemctl suspend`, `hyprctl dispatch exit`, `systemctl reboot`, or
`systemctl poweroff` only after the corresponding selection. Rely on the normal
local-session systemd and polkit authorization path for system power actions.

## Consequences

- Lock, sleep, logout, restart, and poweroff are accessible from the keyboard
  without a terminal.
- Poweroff still requires an explicit confirmation after opening the menu.
- The menu does not currently expose hibernate.
- Unsaved application work remains each application's responsibility after the
  user confirms logout or poweroff.
