# 0010: Use Hyprlock with conservative Hypridle timers

**Status:** Accepted
**Date:** 2026-08-24

## Context

The graphical session can now launch daily applications but has no configured
lock screen or idle protection. Locking must be validated before accounts or
other personal state are added. Suspend introduces separate VM and physical
hardware behavior that has not been tested.

## Decision

Use Hyprlock with PAM authentication and a non-disclosing solid background. Use
Hypridle to lock after five minutes and power displays off after ten minutes,
while respecting application inhibitors. Provide a manual `Super+L` binding.
Do not configure automatic suspend yet.

## Consequences

- An unattended graphical session locks without storing credentials in Git.
- Video and presentation applications can inhibit idle behavior, and Waybar
  exposes a manual inhibitor.
- Display power management can be tested independently of suspend/resume.
- A PAM failure can temporarily lock out repeated attempts, so manual unlock is
  tested before Hypridle is enabled.
