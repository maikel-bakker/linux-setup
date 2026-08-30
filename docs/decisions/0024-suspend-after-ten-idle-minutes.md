# 0024: Suspend after ten idle minutes

**Status:** Accepted
**Date:** 2026-08-30

## Context

The physical workstation's Hyprlock authentication path has been validated.
The earlier conservative policy separated locking and display power-off and did
not suspend automatically, leaving the machine fully powered during extended
idle periods.

## Decision

Use Hypridle to lock the session and power off displays after five idle minutes,
then suspend the machine after ten idle minutes. Keep application idle
inhibitors enabled. Lock again immediately before system sleep and enable the
displays after resume.

## Consequences

- Short idle periods protect the session and stop driving the displays.
- Extended idle periods reduce system power use through suspend.
- Activity between five and ten minutes restores the displays and requires
  authentication.
- Applications can defer all idle actions through supported inhibition
  mechanisms.
- Suspend and resume now require ongoing physical-hardware validation.
