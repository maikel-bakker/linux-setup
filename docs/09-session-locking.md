# Session locking and idle policy

## Policy

Use Hyprlock for PAM-backed session locking and Hypridle for idle detection:

- `Super+L` locks immediately;
- five idle minutes request a session lock and power off the displays;
- activity before suspend enables the displays again;
- ten idle minutes suspend the machine;
- waking from suspend keeps the session locked and enables the displays;
- application idle inhibitors are respected;

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

## Physical validation

Validated on the physical workstation on 2026-08-30:

- the managed Hyprlock screen accepted the normal user password;
- the policy was updated to lock and power off displays after five minutes and
  suspend after ten minutes;
- `hypridle.service` was enabled and started with the managed configuration.

## Deferred

- Longer-term suspend and resume reliability across driver and kernel updates.
- Laptop lid, battery, and backlight rules.
- Wallpaper-backed or per-theme lock screens.
- Fingerprint or hardware-token authentication.
