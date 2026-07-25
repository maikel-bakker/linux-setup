# Host and VM lab

## Physical host inventory

| Component | Observed configuration |
| --- | --- |
| CPU | AMD Ryzen 5 5600G, 6 cores / 12 threads |
| Memory | 32 GiB |
| Discrete GPU | AMD Radeon RX 6600 XT (kernel driver: `amdgpu`) |
| Storage | Two 1 TB Samsung SSD 980 NVMe drives |
| Firmware | UEFI |
| Motherboard | Gigabyte B550 AORUS ELITE AX V2 |
| Host OS | Arch Linux, encrypted root on one NVMe |
| Other OS | Windows on the separate NVMe |

The two operating systems use different physical drives. Preserve this separation unless a later, explicitly documented decision changes it.

## VM host stack

Installed host components:

- QEMU/KVM: virtual-machine emulator and hardware acceleration.
- libvirt: service/API that owns VM definitions, storage, and virtual networks.
- virt-manager: graphical libvirt client.
- edk2-ovmf: UEFI firmware for x86_64 virtual machines.
- dnsmasq: provides the default libvirt NAT network's DHCP/DNS functions.

AMD SVM virtualization is enabled in firmware and `/dev/kvm` is present. The user account belongs to the `libvirt` group and can connect to `qemu:///system`.

The persistent libvirt network named `default` is active and marked to autostart. It is the lab's NAT network.

## First lab VM: intended hardware

| Virtual component | Choice | Why |
| --- | --- | --- |
| CPU | 4 vCPUs | Leaves resources for the host while allowing realistic desktop/development work. |
| Memory | 8 GiB | Enough for a Wayland desktop, Zed, and browser-based development. |
| Disk | 80 GiB qcow2 | Sparse, snapshot-capable, and large enough for the learning system. |
| Firmware | UEFI/OVMF | Matches the physical machine's boot model. |
| Display | Virtio GPU over SPICE | Uses the guest `virtio_gpu` driver; host-side 3D acceleration is deferred. |
| Network | libvirt default NAT | Gives guest internet access without exposing it directly on the LAN. |

## Limits of this lab

The VM will use `virtio_gpu`, not the host's `amdgpu` driver. It is appropriate for testing the base system, filesystem, boot configuration, Wayland, compositors, and desktop tooling. Validate RX 6600 XT-specific behavior—gaming, VRR, sleep/wake, multiple monitors, and hardware video acceleration—on the physical host later.

## Actual first VM

- **Name:** `arch-lab`
- **Storage:** an 80 GiB sparse qcow2 image in libvirt's default storage pool
- **Installer ISO:** `/var/lib/libvirt/images/archlinux-x86_64.iso`, verified before use
- **State:** created and running from the Arch installer ISO

### Deferred: 3D acceleration

The intended configuration was SPICE OpenGL plus a 3D-accelerated Virtio GPU. QEMU 11.0.2 on this host rejected its SPICE video-codec configuration when OpenGL was enabled, despite the relevant SPICE and GStreamer packages being installed. The VM therefore currently uses 2D Virtio graphics. This does not change the guest driver (`virtio_gpu`); it limits accelerated rendering. Investigate this independently after the base VM is stable.
