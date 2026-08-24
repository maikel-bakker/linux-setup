# 0017: Use a repository-native desktop theme switcher

**Status:** Accepted
**Date:** 2026-08-24

## Context

The desktop has a hard-coded Catppuccin Mocha palette across several independent
applications. Zed also selects Mocha, while GTK applications still depend on the
system color preference. Rofi can present a theme menu but cannot apply colors
to other programs. General palette generators still require application-specific
integration and reload behavior.

Omarchy solves this with its own palettes, generated application files, active
theme state, and a graphical menu. Importing that complete runtime would add
assumptions and components not selected for this system.

## Decision

Implement a small repository-native switcher. Store native application color
fragments under `themes/<name>/`, expose the active directory through one user
configuration symlink, and make stable application configs import those
fragments. Use Rofi as the graphical chooser. Begin with Catppuccin Mocha and
Catppuccin Latte, and synchronize Zed and GTK through the system dark/light
preference. Allow a theme to assign one repository-owned wallpaper by relative
path; themes without one retain the compositor's plain background.

## Consequences

- One command changes the selected desktop palette consistently.
- New themes must provide every required color fragment.
- Rofi remains replaceable because it is only a front end to the switcher.
- Application-specific reload limitations remain explicit.
- Browser content and remote web applications are not automatically themed.
- Wallpaper assets require recorded provenance and explicit per-theme
  assignment.
