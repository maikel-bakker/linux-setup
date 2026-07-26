# 0004: Use LUKS2, Btrfs subvolumes, and systemd-boot

**Status:** Accepted  
**Date:** 2026-07-26

## Context

The system needs encrypted private data, a simple UEFI boot path, independent snapshot/rollback boundaries, and a design that can be repeated in a VM and on the physical computer. Hibernation is not required.

## Decision

Use a 1 GiB unencrypted EFI System Partition and a LUKS2 container for the rest of the disk. Place Btrfs inside LUKS2 with separate subvolumes for root, home, logs, package cache, and snapshots. Use systemd-boot and a systemd/mkinitcpio initramfs with `sd-encrypt` to unlock the LUKS root volume.

## Consequences

- All regular system and user data is encrypted at rest.
- Bootloader, kernel, initramfs, and microcode images reside unencrypted on the EFI partition.
- Btrfs snapshots can exclude or include logs and package cache intentionally.
- A LUKS passphrase is required at each boot; zram will provide swap later, with no hibernation support.
- Secure Boot and TPM-assisted unlocking are deferred decisions.
