# Desktop-wide theme switching

## Architecture

Use repository-managed native color fragments rather than a third-party theme
daemon. Each theme directory contains the colors needed by Hyprland, Waybar,
Kitty, Rofi, Mako, and Hyprlock. Stable application configs import a fragment
through `~/.config/linux-setup/theme`, which points to the active repository
theme.

Zed retains one editable settings file. It follows the system light/dark
preference and auto-installs the Catppuccin theme and icon extensions. GTK 3
applications such as Blueman and GTK 4 applications such as Pavucontrol use the
matching `adw-gtk3` variant supplied by Arch's `adw-gtk-theme` package. The
active theme's `gtk-settings.ini` is linked as the settings file for both GTK
versions. Libadwaita applications such as Nautilus follow the system color
preference. Browser page content, websites, and account-specific browser themes
remain outside this mechanism.

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
color preference and GTK theme, applies an assigned wallpaper, and reloads
running components where supported. The saved selection is restored whenever
Hyprland starts. Restart an already-running GTK application after changing
themes so it rebuilds its interface with the selected variant.

## Scope and safety

- Theme directories contain presentation data only.
- The switcher accepts only names of existing repository theme directories.
- No theme may contain executable hooks, credentials, or downloaded artwork.
- Zed extensions are declared by identifier; their downloaded data remains in
  Zed's local data directory and outside Git.
- Wallpaper assets are stored separately under `assets/wallpapers/`, with
  creator, source, and copyright recorded alongside them. A theme may opt in by
  providing a `wallpaper` file containing the repository-relative asset path.
- Mocha assigns `desert-catppuccin-darker.png`; Hyprpaper displays it in `cover`
  mode.
  Latte has no assignment, so selecting it stops Hyprpaper and returns to the
  compositor's plain background.
- Hyprpaper is skipped by default in virtual machines because the lab's QEMU
  graphics stack cannot allocate its GBM buffer. Native installations apply the
  wallpaper normally. `LINUX_SETUP_ALLOW_VM_WALLPAPER=1` permits an explicit VM
  test.

## Lab validation

Validated in `arch-lab` on 2026-08-24. Both Mocha and Latte passed Rofi's theme
validator and Hyprland's configuration parser. A live Latte-to-Mocha round trip
kept Waybar active, reloaded Mako, updated the GTK color preference, changed the
active theme link, and persisted the selected name. Mocha remains the active
default after validation. The wallpaper path and Latte cleanup were validated
on the same date; Hyprpaper itself segfaults in this VM's software renderer, so
native wallpaper rendering remains a physical-host validation item.
