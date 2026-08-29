# 0020: Add Brave browser

**Status:** Accepted
**Date:** 2026-08-29

## Context

The browser layer already includes Firefox and Google Chrome. A third browser
with integrated tracker and advertisement blocking is useful for normal
browsing and for comparing site behavior across privacy configurations. Brave
does not publish a package in Arch's signed repositories; its own Linux guide
directs Arch users to the AUR `brave-bin` package.

## Decision

Add the stable `brave-bin` package base to the review-first AUR browser
manifest. Use the existing `prepare-aur-package` workflow to inspect every
tracked packaging file, verify pinned source checksums, and build an unchanged
checkout without introducing an automatic AUR helper.

## Consequences

- The browser layer contains Firefox, Google Chrome, and Brave.
- Brave installation and updates require a fresh explicit AUR review.
- The binary is downloaded from Brave's release infrastructure and packaged
  locally by a user-maintained recipe.
- Browser profiles, sync data, Rewards state, and credentials remain unmanaged
  local state.
