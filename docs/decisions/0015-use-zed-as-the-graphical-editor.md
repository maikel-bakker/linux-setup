# 0015: Use Zed as the graphical editor

**Status:** Accepted
**Date:** 2026-08-24

## Context

The web-development layer has browsers and command-line tooling but no selected
graphical editor. Zed offers a fast native interface, Wayland support, an
integrated terminal, and project collaboration features. Its Linux renderer
requires Vulkan, whose driver is hardware-specific.

## Decision

Install Zed from Arch's signed `extra` repository. Keep the editor package in a
hardware-independent manifest and record the lab's `vulkan-virtio` provider in
a separate lab manifest. Defer editor settings and account integration until the
base application is validated.

## Consequences

- Zed is managed and updated by pacman.
- The VM and physical host can select different Vulkan drivers without changing
  the editor choice.
- Zed adds a substantial application and graphics dependency footprint.
- The current VM cannot validate Zed's accelerated renderer, so physical-host
  adoption requires a separate Vulkan test with the AMD driver.
- Project layout automation and editor customization remain later sublayers.
