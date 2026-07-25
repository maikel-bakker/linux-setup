# 0001: Use a setup repository as the reproducible source of truth

**Status:** Accepted  
**Date:** 2026-07-25

## Context

A custom installation image, a VM disk image, and filesystem snapshots can all speed up recovery or cloning. None clearly describes which parts of the system are intentional or lets us review each design decision over time.

## Decision

Maintain this Git repository as the source of truth for the chosen system. It will contain documentation, package manifests, system configuration templates, user configuration, and repeatable scripts. Test a clean rebuild in a VM before adopting changes on the physical host.

## Consequences

- Initial setup is more deliberate and requires documentation work.
- Rebuilds become reviewable and less dependent on a particular disk image.
- Snapshots remain part of the recovery strategy but are not treated as the configuration source.
- A custom Arch ISO may be considered later as a convenience layer built from this design.
