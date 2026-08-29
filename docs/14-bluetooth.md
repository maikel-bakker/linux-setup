# Bluetooth peripherals

## Selection

Use BlueZ, Linux's standard Bluetooth stack, with Blueman as its graphical
device manager. Retain `bluetoothctl` for terminal-based pairing, inspection,
and recovery. Pairing records, device addresses, and link keys are machine-local
state and must never be committed.

## Install and enable

Install the daemon and command-line tools, then enable the system service:

```sh
sudo ./scripts/install-packages packages/50-bluetooth.txt
sudo ./scripts/configure-bluetooth
```

Launch the graphical manager from Rofi or a terminal:

```sh
blueman-manager
```

The package also provides `blueman-applet` for a persistent tray icon. The
applet is not started automatically by the managed Hyprland configuration;
launch it manually until its role in the session is validated.

The managed Waybar configuration has a native Bluetooth status module directly
after the audio controls. Its icon indicates controller and connection state,
its tooltip lists connected devices, and a left click opens `blueman-manager`.
When BlueZ reports a device battery percentage, the module displays it beside
the connected icon. Reapply the desktop theme or restart Waybar after updating:

```sh
./scripts/apply-desktop-theme
systemctl --user restart waybar.service
```

If the controller is radio-blocked, inspect and unblock it:

```sh
rfkill list bluetooth
sudo rfkill unblock bluetooth
```

## Pair a mouse

In Blueman, select **Search**, choose the mouse by name, and select **Pair**.
Mark it trusted if Blueman does not do so automatically, allowing it to
reconnect after a reboot or wake.

The equivalent terminal workflow remains available. Put the mouse into pairing
mode, then start the interactive controller as the normal user:

```sh
bluetoothctl
```

At the `bluetoothctl` prompt, enable the controller and scan:

```text
power on
agent on
default-agent
scan on
```

Wait for the mouse to appear and copy its Bluetooth address. Substitute that
address in the following commands:

```text
pair AA:BB:CC:DD:EE:FF
trust AA:BB:CC:DD:EE:FF
connect AA:BB:CC:DD:EE:FF
scan off
quit
```

`trust` allows BlueZ to reconnect the mouse after a reboot or after it wakes.
Do not record the real device address in this repository.

## Validate and troubleshoot

Confirm the service and connection:

```sh
systemctl is-active bluetooth.service
bluetoothctl show
bluetoothctl devices Connected
```

If no controller appears, check whether the kernel detected its USB or PCI
adapter and inspect the service log:

```sh
bluetoothctl list
rfkill list
journalctl -b --no-pager -u bluetooth.service
```

Pairing and reconnection require physical-hardware validation because the
`arch-lab` VM does not expose the host Bluetooth controller.

## Physical workstation controller selection

The physical workstation currently exposes two Bluetooth controllers:

- the external Broadcom `0a5c:21e8` receiver, which should remain enabled;
- the motherboard Realtek `13d3:3586` Bluetooth function, which should be
  disabled.

The motherboard's RTL8852CE Wi-Fi function is a separate PCIe device. The
repository rule disables only the internal USB Bluetooth function and does not
disable Wi-Fi. Apply the rule while both expected devices are present:

```sh
sudo ./scripts/configure-bluetooth-adapters
reboot
```

The script refuses to install the rule unless it detects both exact USB device
IDs. After rebooting, confirm that only the external controller remains:

```sh
bluetoothctl list
```

To restore the motherboard Bluetooth controller, remove the installed rule,
reload udev, and reboot:

```sh
sudo rm /etc/udev/rules.d/80-disable-onboard-bluetooth.rules
sudo udevadm control --reload
reboot
```

Validated on the physical workstation on 2026-08-29: after applying the rule
and rebooting, the onboard Realtek controller was absent and the remaining
`hci0` resolved to the external Broadcom BCM20702A0 receiver (`0a5c:21e8`).
