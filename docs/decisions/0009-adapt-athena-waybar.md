# 0009: Adapt the Athena Waybar design

**Status:** Accepted
**Date:** 2026-08-24

## Context

The initial Waybar proved the service model and removed the crashing packaged
power menu, but its plain text layout was only a diagnostic baseline. The Athena
Waybar configuration by Muhammad Haikal Hakim provides the desired capsule
layout, drawers, persistent workspace display, application glyphs, and compact
system controls. Its complete configuration assumes packages and hardware not
present in this lab.

## Decision

Adapt Athena's MIT-licensed Waybar configuration to this setup and retain its
copyright and license notice in `dotfiles/waybar/LICENSE.athena`. Preserve its
visual structure and core interactions while using the existing Catppuccin
Mocha palette.

Omit Jakarta-specific time, battery, Bluetooth, a fixed thermal zone,
power-profiles-daemon, SwayNC, unavailable application launchers, and scroll
actions that toggle Wi-Fi. Add only JetBrains Mono Nerd Font, Pavucontrol, and
NetworkManager's graphical editor for interactions retained by the adapted bar.

## Consequences

- Waybar closely follows Athena's appearance without pretending that the VM has
  laptop hardware or Athena's full application stack.
- The source and license of the adapted design remain visible in the repository.
- Drawers, sliders, glyphs, and persistent workspace indicators make the bar
  more capable and more complex than the diagnostic configuration.
- Additional Athena modules can be evaluated later as their underlying features
  are deliberately added to this system.
