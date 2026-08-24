# Catppuccin Mocha desktop theme

## Scope

Catppuccin Mocha established the first coherent desktop palette. The later
repository-native switcher adds Catppuccin Latte and moves application colors
into active native fragments; see `docs/12-theme-switching.md`.

The first themed Waybar was a deliberately small diagnostic configuration. It
was later replaced by an adaptation of Muhammad Haikal Hakim's MIT-licensed
[Athena Waybar](https://github.com/haikal-hakim/athena/tree/main/.config/waybar).
The adapted bar retains Athena's capsule groups, drawers, persistent workspace
display, glyphs, and audio slider while continuing to use Catppuccin Mocha.

Hardware- and setup-specific Athena modules are omitted: battery, Bluetooth,
fixed thermal-zone monitoring, power profiles, SwayNC, and launchers for apps
not selected here. The bar does not include a power button: Waybar's packaged
example referenced a missing user menu file and crashed when clicked.

## Apply

```sh
./scripts/apply-desktop-theme
systemctl --user restart waybar.service
makoctl reload
```

Open a new Kitty window and invoke Rofi to see their updated configuration.
Hyprland reloads its linked configuration when the file changes. Use
`Super+Ctrl+Space` to select between the managed desktop themes.

The Athena adaptation also requires the packages recorded in the Hyprland
session manifest:

```sh
sudo ./scripts/install-packages packages/41-hyprland-session.txt
```

Waybar runs as a managed systemd user service with `Restart=on-failure`, so an
unexpected crash no longer leaves the session without a bar. Power actions will
be added only with an explicit confirmation menu.

## Wallpaper

The initial palette uses Hyprland's plain background. An original bitmap
wallpaper is deferred because the image-generation facility was unavailable in
the session. Do not add downloaded artwork without recording its source and
license, and never store credentials for image services in the repository.

## Lab validation

Applied in `arch-lab` on 2026-07-29. Waybar loaded the managed JSON and CSS,
connected to Hyprland IPC, and configured a 32-pixel bar for `Virtual-1`. The
old directly launched Waybar process was stopped, leaving only the active
systemd-managed instance. The original Fuzzel configuration was later replaced
by a managed Rofi configuration. Hyprland accepted
the updated Lua theme, and the Waybar unit passed systemd verification.

The Athena adaptation was loaded successfully on 2026-08-24 with its group
drawers, persistent workspaces, audio slider, and Catppuccin CSS. The requested
height was adjusted from Athena's 42 pixels to 43 because the current Waybar/GTK
stack reported 43 as the minimum for these modules.

Rofi 2.0 replaced Fuzzel on 2026-08-24. `Super+Space` opens the native Wayland
launcher with the managed Catppuccin Mocha Rasi theme, the theme passes Rofi's
validator, and the superseded Fuzzel package and managed configuration were
removed.
