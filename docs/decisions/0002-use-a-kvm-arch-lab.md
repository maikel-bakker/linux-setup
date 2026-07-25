# 0002: Use a KVM Arch lab as the first implementation target

**Status:** Accepted  
**Date:** 2026-07-25

## Context

The physical host is a daily-driver system with encrypted Arch Linux and a separate Windows NVMe. The setup needs a safe environment for repeated installation, configuration, and recovery exercises.

## Decision

Use the `arch-lab` UEFI virtual machine under QEMU/KVM and libvirt as the initial target. Give it 4 vCPUs, 8 GiB memory, an 80 GiB sparse qcow2 disk, Virtio networking on libvirt's default NAT network, and Virtio graphics over SPICE.

## Consequences

- Destructive filesystem and boot experiments are isolated from both physical operating systems.
- Clean rebuilds can verify the setup repository.
- The lab does not test the physical AMD GPU driver or GPU-specific behavior.
- Host-side 3D Virtio acceleration is deferred because the current QEMU/SPICE stack rejects its generated video-codec configuration. The base lab uses 2D Virtio graphics until that is resolved.
