# 0005: Use zram, timesyncd, rootless SSH, and manual full updates

**Status:** Accepted  
**Date:** 2026-07-26

## Context

The system needs responsive behavior under memory pressure, correct time, safe remote administration, and an upgrade policy compatible with a consciously managed Arch system. Hibernation is not required.

## Decision

Use zram-generator for compressed RAM swap, systemd-timesyncd for NTP, and SSH for the normal `mb` user only. Disable root SSH login. Apply Arch upgrades manually and only as full `pacman -Syu` transactions.

## Consequences

- The system has no hibernation support and no disk swap partition.
- Memory pressure is handled before applications reach an out-of-memory condition, with CPU cost for compression.
- SSH administration uses a normal account plus `sudo` rather than remotely accessible root credentials.
- Updates are deliberate and reviewable; automatic security patching is not yet configured.
