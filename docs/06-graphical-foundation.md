# Graphical foundation

This layer establishes graphics, desktop audio, and fonts without choosing a
desktop environment, compositor, display manager, terminal, or portal backend.
Keeping those policy choices out of the foundation makes it possible to compare
Wayland sessions without changing the underlying media stack each time.

## Packages

Install the graphical base from its manifest:

```sh
sudo ./scripts/install-packages packages/40-graphical-base.txt
```

The manifest provides:

- Mesa for the VM's Virtio GPU and the physical host's AMD GPU;
- PipeWire audio with ALSA, JACK, and PulseAudio compatibility;
- RealtimeKit so unprivileged PipeWire threads can request safe real-time
  scheduling;
- WirePlumber as the PipeWire session manager;
- Noto text and emoji fonts as a predictable baseline.

The physical RX 6600 XT will need Vulkan and 32-bit gaming packages in the
gaming layer. They are not required to validate the Virtio-based lab desktop.

## Service model

PipeWire and WirePlumber are systemd user services activated by their sockets
and the user session. Do not enable them as system services or run them as root.

If the packages were installed from an already-running login session, load the
new global user-unit links and start the sockets explicitly:

```sh
systemctl --user daemon-reload
systemctl --user start pipewire.socket pipewire-pulse.socket
```

A completely new login starts the globally enabled sockets without this step.
Inspect the services and graph with:

```sh
systemctl --user --no-pager status pipewire.socket pipewire-pulse.socket
systemctl --user --no-pager status pipewire wireplumber
wpctl status
```

An SSH-only VM may report no audio devices even when the services are healthy;
repeat the check from the eventual graphical session. `pipewire-pulse.service`
may remain inactive until the first PulseAudio-compatible client connects; its
active socket is the relevant idle-state check. RealtimeKit is a system D-Bus
service and starts on demand; its absence produces `ServiceUnknown` warnings and
forces PipeWire to use lower scheduling priority.

## Deliberately deferred

- The compositor or desktop environment and how it is started.
- A display manager or TTY login workflow.
- The terminal emulator and application launcher.
- `xdg-desktop-portal` and its backend, which must match the chosen session.
- Vulkan, 32-bit graphics libraries, Bluetooth audio, and gaming packages.

The next step is to choose one minimal Wayland session for the lab, record the
choice, and add its packages and configuration before installing it.

## Lab validation

Validated in `arch-lab` on 2026-07-26:

- both PipeWire sockets, PipeWire, and WirePlumber were active;
- `wpctl status` connected successfully and showed the WirePlumber client;
- RealtimeKit was installed and the earlier real-time scheduling warnings did
  not recur after restarting PipeWire and WirePlumber;
- the SSH session exposed no audio or video devices, as expected before testing
  from a graphical SPICE session.

WirePlumber's missing-libcamera notice is harmless for the current VM, which has
no camera requirement. Add camera support only if a real use case appears.
