# Linux setup

This repository is the source of truth for a deliberately minimal Arch Linux daily-driver setup. It is designed and tested in a KVM virtual machine before changes are adopted on the physical machine.

## Rebuild philosophy

The Arch ISO is only the bootstrap environment. A rebuild should use the repository to recreate the selected packages, system configuration, user configuration, and documented manual steps. Do not treat a disk image or a snapshot as the source of truth.

Snapshots are still useful for rollback. They are not a substitute for a documented rebuild.

## Project order

1. Establish and document a KVM-based Arch lab.
2. Install a small Arch base in the VM, manually and with explanations.
3. Record each accepted decision as a package manifest, configuration file, script, or decision record.
4. Rebuild a fresh VM from the repository and close any gaps.
5. Apply the proven design to the physical Arch installation.

## Layer map

| Layer | Scope | Status |
| --- | --- | --- |
| 0 | Principles, hardware inventory, VM lab | In progress |
| 1 | Disk layout, encryption, filesystem, boot | Implemented in lab |
| 2 | Base OS, kernel, drivers, network, audio | In progress |
| 3 | Users, security, secrets, permissions | In progress |
| 4 | Display, compositor/window manager, session | In progress |
| 5 | Shell, terminal, editor, web development | In progress |
| 6 | Gaming, peripherals, media | Planned |
| 7 | Backups, upgrades, monitoring, recovery | Planned |

## Repository conventions

- `docs/` explains intent, tradeoffs, and manual recovery paths.
- `docs/decisions/` contains short, immutable decision records. A later decision supersedes an earlier one; it does not rewrite history.
- `packages/` will hold explicit package lists, grouped by layer.
- `system/` will hold templates for system configuration, never host-specific secrets.
- `dotfiles/` will hold user configuration.
- `scripts/` will contain repeatable, idempotent steps wherever practical.

Secrets, private keys, passwords, tokens, and machine-specific encryption material must never enter this repository.

## Package manifests

Install one or more package manifests with:

```sh
sudo ./scripts/install-packages packages/00-bootstrap.txt packages/10-core-services.txt
```

The script ignores empty lines and comments, and passes the remaining package names to `pacman -S --needed`. Add a package to the appropriate manifest before installing it on the system.

Apply the login-shell choice after installing the shell manifest:

```sh
sudo ./scripts/configure-shell mb
```

Configure the standard DNS resolver before installing tools that make network
requests:

```sh
sudo ./scripts/configure-systemd-resolved
```

Install the compositor-independent graphics and audio foundation before testing
a graphical session:

```sh
sudo ./scripts/install-packages packages/40-graphical-base.txt
```

Install the Hyprland session only after the graphical foundation:

```sh
sudo ./scripts/install-packages packages/41-hyprland-session.txt
./scripts/apply-hyprland-config
```

Apply the managed Catppuccin Mocha theme after validating the first session:

```sh
./scripts/apply-desktop-theme
```
