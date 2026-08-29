# Session locking and idle policy

## Policy

Use Hyprlock for PAM-backed session locking and Hypridle for idle detection:

- `Super+L` locks immediately;
- five idle minutes request a session lock;
- ten idle minutes power off the displays;
- input after display power-off enables them again;
- application idle inhibitors are respected;
- suspend is deliberately not configured yet.

The lock screen uses a solid Catppuccin Mocha background instead of a screenshot
of the unlocked session. The repository contains presentation and timing only;
passwords and authentication material remain in PAM and are never stored here.

## Apply and test safely

Apply the configs without starting the idle daemon:

```sh
./scripts/apply-lock-config
hyprlock
```

Type the normal `mb` password and press Enter. Arch's default PAM configuration
may impose a ten-minute lockout after three failed attempts, so test carefully.
If unlocking fails, switch to another VM TTY or use the existing SSH session to
inspect logs rather than repeatedly guessing:

```sh
journalctl --user -b --no-pager -u hypridle.service
journalctl -b --no-pager | grep -i hyprlock
```

Only after one successful manual unlock, enable the idle daemon:

```sh
systemctl --user enable --now hypridle.service
systemctl --user --no-pager status hypridle.service
```

Then verify `Super+L`. Applications can request idle inhibition through the
normal Wayland and systemd mechanisms when needed for video or presentations;
Waybar does not expose a manual override.

## Lab validation

Validated in `arch-lab` on 2026-08-24:

- a manual Hyprlock launch accepted the normal user password and unlocked;
- `hypridle.service` was enabled and started successfully;
- Hypridle loaded both managed timeout rules: lock after five minutes and
  display power-off after ten minutes.

## Deferred

- Suspend and resume behavior.
- Laptop lid, battery, and backlight rules.
- Wallpaper-backed or per-theme lock screens.
- Fingerprint or hardware-token authentication.
