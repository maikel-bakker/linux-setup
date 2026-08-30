# Hyprland graphical session

## Session choice

Use Hyprland as the first Wayland compositor and Kitty as the terminal. Hyprland
provides dynamic tiling and the visual theming capabilities wanted for the daily
desktop. Exact task-oriented development workspaces will be added after the
basic session is proven.

The initial supporting components are:

- Waybar for workspace and system status;
- Rofi for application launching and window switching;
- Mako for notifications;
- Hyprpolkitagent for graphical privilege prompts;
- the Hyprland and GTK portal backends for screen sharing and file dialogs;
- Xwayland for applications that do not support Wayland natively;
- Nautilus (GNOME Files) for graphical file management;
- `wl-clipboard`, Grim, and Slurp for clipboard and screenshot primitives;
- Satty for post-capture cropping and annotation;
- Hyprpaper, Hyprlock, and Hypridle for later wallpaper, lock, and idle policy.

Hyprlock and Hypridle are installed but intentionally not started by the first
configuration. Locking a new graphical session before its unlock path has been
tested would make initial diagnosis unnecessarily difficult.

## Install and configure

Install the recorded packages, then apply the user configuration as `mb`:

```sh
sudo ./scripts/install-packages packages/41-hyprland-session.txt
./scripts/apply-hyprland-config
```

The apply script links `~/.config/hypr/hyprland.lua` to the repository. It will
not overwrite a different regular file.

## Session launch

No display manager or automatic login is selected. The managed Zsh login profile
starts Hyprland automatically through the packaged watchdog after `mb` logs in
on `tty1`. Authentication therefore remains at the normal TTY login prompt.
SSH and secondary TTYs do not start a graphical session and remain available
for recovery.

For a manual launch from another local TTY—not an SSH shell—run:

```sh
start-hyprland
```

`start-hyprland` is the packaged watchdog/session wrapper used by Hyprland's
desktop entry. Use the raw `Hyprland` binary for diagnostics such as config
verification, not as the normal launcher.

Useful initial bindings:

| Binding | Action |
| --- | --- |
| `Super+Enter` | Open Kitty |
| `Super+Space` | Open Rofi |
| `Super+F` | Open Nautilus |
| `Super+B` | Open the default browser |
| `Super+Shift+B` | Open the Bluetooth manager |
| `Super+S` | Open Spotify |
| `Super+W` | Close the focused window |
| `Super+Escape` | Open the power menu |
| `Print` | Select, capture, and annotate a screen region |
| `Super+M` | Exit Hyprland |
| `Super+1` … `Super+0` | Select workspace 1 … 10 |
| `Super+Shift+1` … `Super+Shift+0` | Move a window to a workspace |
| `Super` + arrow | Change focus |
| `Super+Shift` + left/right arrow | Swap the focused window with its neighbor |
| `Super+J` | Toggle the next tiled split between horizontal and vertical |
| `Super` + left/right mouse drag | Move/resize a window |

Validate Kitty, Rofi, Waybar, notifications, window tiling, keyboard/mouse
input, SPICE display resizing, and `wpctl status` from inside the session. Exit
with `Super+M` and inspect the journal if the session fails:

```sh
journalctl --user -b --no-pager | tail -200
```

`Super+Escape` opens a Rofi power menu ordered as **Power off**, **Lock**,
**Restart**, **Sleep**, **Log out**, and **Cancel**, with Power off preselected.
Lock launches Hyprlock unless it is already running, Sleep runs
`systemctl suspend`, Log out cleanly exits Hyprland, Restart runs
`systemctl reboot`, and Power off runs `systemctl poweroff`. Pressing Escape
dismisses the menu without taking action. Apply the desktop theme after the
repository is updated so the helper is linked into `~/.local/bin`:

```sh
./scripts/apply-desktop-theme
```

Hyprland invokes repository-owned theme and power helpers through their managed
absolute paths under `~/.local/bin`; session controls therefore do not depend on
the compositor's inherited shell `PATH`.

The Print key runs `linux-setup-screenshot`. Slurp selects a region, Grim emits
an uncompressed capture to Satty, and Satty provides cropping and annotation.
Press Enter or `Ctrl+C` in Satty to copy through `wl-copy`, `Ctrl+S` to save
under `~/Pictures/Screenshots`, or Escape to cancel. Apply the desktop theme to
link the helper after a repository update:

```sh
./scripts/apply-desktop-theme
```

## Installation validation

Installed in `arch-lab` on 2026-07-28. The complete manifest was present,
including the explicitly selected `pipewire-jack` provider. Hyprland's own
parser accepted the managed configuration:

```sh
Hyprland --verify-config --config ~/.config/hypr/hyprland.lua
```

The remaining validation requires the VM's graphical console and begins by
running `start-hyprland` from its local TTY.

The first graphical launch confirmed Hyprland, Waybar, Mako, both portal
backends, portal screen-copy integration, and the Virtio audio devices. The
polkit agent is supplied only as a systemd user service, so the managed config
starts `hyprpolkitagent.service` rather than looking for a command on `PATH`.

Nautilus replaced Thunar in the lab on 2026-08-24. `Super+F` and Waybar launch
Nautilus successfully, and the superseded Thunar package was removed.

## Deferred until first-session validation

- Display manager versus TTY-based startup.
- Wallpaper and full color/theme selection.
- Lock and idle timeouts.
- Named web-development workspace scripts and window rules.
- Clipboard history, network tray, and additional desktop widgets.
