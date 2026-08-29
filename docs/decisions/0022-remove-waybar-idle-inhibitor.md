# 0022: Remove the Waybar idle inhibitor

**Status:** Accepted
**Date:** 2026-08-29

## Context

The Waybar idle-inhibitor module exposes a persistent manual toggle that can
silently prevent the configured lock and display timeouts. The control is not
needed for the normal workstation workflow and adds ambiguity to the center of
the bar.

## Decision

Remove the manual idle-inhibitor module from Waybar. Continue respecting idle
inhibition requested by applications through the normal Wayland, D-Bus, and
systemd mechanisms.

## Consequences

- The center of Waybar contains only workspace status.
- The user cannot accidentally leave a persistent manual inhibitor enabled.
- Video and presentation applications can still inhibit the configured idle
  actions when they explicitly request it.
- A manual override can be reintroduced later if a concrete workflow needs it.
