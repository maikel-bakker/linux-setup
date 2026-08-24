# Desktop-wide theme switching

## Architecture

Use repository-managed native color fragments rather than a third-party theme
daemon. Each theme directory contains the colors needed by Hyprland, Waybar,
Kitty, Rofi, Mako, and Hyprlock. Stable application configs import a fragment
through `~/.config/linux-setup/theme`, which points to the active repository
theme.

Zed retains one editable settings file. It follows the system light/dark
preference and auto-installs the Catppuccin theme and icon extensions. GTK 4
applications such as Nautilus follow the same preference. Browser page content,
websites, and account-specific browser themes remain outside this mechanism.

The initial themes are:

- `catppuccin-mocha` for dark mode;
- `catppuccin-latte` for light mode.

This is inspired by Omarchy's palette-driven theme activation, but deliberately
smaller: it manages only the components selected by this repository and does not
import Omarchy's shell, templates, or runtime.

## Apply and select

Apply the desktop configuration once, then select a theme by name:

```sh
./scripts/apply-desktop-theme
linux-setup-theme catppuccin-mocha
```

Open the graphical selector with `Super+Ctrl+Space`, or run:

```sh
linux-setup-theme-menu
```

Rofi only provides the chooser. `scripts/set-theme` validates and atomically
changes the active theme link, records its name under user state, updates the GTK
color preference, and reloads running components where supported.

## Scope and safety

- Theme directories contain presentation data only.
- The switcher accepts only names of existing repository theme directories.
- No theme may contain executable hooks, credentials, or downloaded artwork.
- Zed extensions are declared by identifier; their downloaded data remains in
  Zed's local data directory and outside Git.
- Wallpapers are deferred until an original or appropriately licensed asset is
  selected for each theme.

## Lab validation

Validated in `arch-lab` on 2026-08-24. Both Mocha and Latte passed Rofi's theme
validator and Hyprland's configuration parser. A live Latte-to-Mocha round trip
kept Waybar active, reloaded Mako, updated the GTK color preference, changed the
active theme link, and persisted the selected name. Mocha remains the active
default after validation.
