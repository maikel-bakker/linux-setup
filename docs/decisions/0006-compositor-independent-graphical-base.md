# 0006: Separate the graphical foundation from the desktop session

**Status:** Accepted
**Date:** 2026-07-26

## Context

The lab needs working graphics, desktop audio, and fonts before evaluating a
Wayland compositor. Bundling these with a desktop environment would make it
harder to see which packages are foundational and which express session policy.
The VM also cannot validate the physical AMD GPU's full gaming feature set.

## Decision

Use Mesa for the common graphics userspace, PipeWire with WirePlumber and
RealtimeKit for audio, and Noto text and emoji fonts as the
compositor-independent graphical base.
Select the compositor, display manager, portal backend, Vulkan stack, and
32-bit gaming libraries in later layers where their requirements are known.

## Consequences

- Candidate Wayland sessions can share one graphics and audio foundation.
- PipeWire supports ALSA, JACK, and PulseAudio clients without running separate
  JACK or PulseAudio servers. Selecting `pipewire-jack` explicitly also avoids
  an ambiguous `jack` provider prompt during later desktop package installs.
- RealtimeKit lets normal user processes obtain constrained real-time scheduling
  for reliable low-latency audio.
- Portal behavior cannot be validated until a session-specific backend exists.
- Virtio graphics can be tested in the VM, while AMD Vulkan and gaming behavior
  remain physical-host validation work.
