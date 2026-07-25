# Principles

## Intent

Build an Arch Linux system that is suitable for daily web development and gaming while remaining understandable, intentionally minimal, and rebuildable.

## Rules

1. Add software only for a known purpose and record that purpose.
2. Prefer standard Arch and systemd mechanisms before adding framework layers.
3. Test consequential changes in the VM before changing the physical host.
4. Keep the physical Windows installation isolated from the Arch design work.
5. Separate rollback from reproducibility: snapshots recover state; this repository recreates it.
6. Keep secrets out of version control. Document how they are supplied, not their values.
7. Favor a small number of well-understood tools over overlapping tools.

## Non-goals, for now

- Replacing the current physical Arch installation.
- GPU passthrough.
- Building a custom Arch ISO.
- Automating a layer before its manual installation is understood.
