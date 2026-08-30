# 0023: Use Satty for screenshots

**Status:** Accepted
**Date:** 2026-08-30

## Context

The graphical session already includes Grim, Slurp, and wl-clipboard, but their
raw capture workflow does not provide cropping or annotation. Screenshot tools
designed around X11 add unnecessary compatibility complexity under Hyprland.

## Decision

Install Satty from Arch's signed repositories and feed it region captures from
Grim and Slurp through a repository-managed script. Bind the Print key to that
script, copy through wl-clipboard, and save explicitly requested files under
`~/Pictures/Screenshots`.

## Consequences

- Region capture and annotation are accessible through one key.
- Screenshots can be copied without creating a file or saved with a timestamped
  filename.
- The workflow remains composed of small Wayland-native tools.
- Full-monitor and active-window shortcuts can be added later if repeated use
  shows they are needed.
