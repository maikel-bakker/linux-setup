# 0018: Use BlueZ for Bluetooth peripherals

**Status:** Accepted
**Date:** 2026-08-29

## Context

The physical workstation needs Bluetooth input-device support. The Arch lab VM
does not expose the host Bluetooth controller, so pairing cannot be validated
there. The initial terminal workflow works for diagnosis, but selecting devices
by name and managing connections is more convenient in a graphical interface.

## Decision

Install the official Arch `bluez`, `bluez-utils`, and `blueman` packages and
enable `bluetooth.service`. Use Blueman for normal graphical pairing and retain
`bluetoothctl` for terminal-based management and troubleshooting. Keep
paired-device records, addresses, and link keys outside the repository.
On the physical workstation, disable the motherboard Realtek `13d3:3586`
Bluetooth USB function with a device-specific udev rule and retain the external
Broadcom `0a5c:21e8` receiver. Do not blacklist `btusb`, because both
controllers use that driver.

## Consequences

- Bluetooth setup is reproducible from a package manifest and idempotent script.
- Pairing remains an explicit, machine-local action requiring physical access.
- Trusted devices can reconnect automatically after the initial pairing.
- Blueman adds a GTK graphical manager and optional tray applet to the desktop.
- The managed Hyprland session does not start the tray applet until its ongoing
  role has been validated.
- The physical-host rule leaves its separate PCIe Wi-Fi function enabled and
  refuses installation unless both expected Bluetooth devices are present.
