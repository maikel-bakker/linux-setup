# 0011: Use Nautilus for graphical file management

**Status:** Accepted
**Date:** 2026-08-24

## Context

The initial Hyprland layer selected Thunar as a lightweight graphical file
manager. A more polished file browser with integrated search, previews, network
locations, and removable-device handling better matches the intended desktop
experience. Omarchy also uses Nautilus, making its workflows and visual examples
more directly applicable to this setup.

## Decision

Use Nautilus (GNOME Files) as the graphical file manager and launch it with
`Super+F`. Keep the selection explicit in the Hyprland session package manifest
rather than installing a full GNOME desktop environment.

## Consequences

- File management gains Nautilus's GNOME/GTK integration and broader features.
- Nautilus and its dependencies use more disk space than Thunar.
- This does not install or select GNOME Shell as the desktop environment.
- Existing lab installations should remove Thunar after Nautilus is validated.
