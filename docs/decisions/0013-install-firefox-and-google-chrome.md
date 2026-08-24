# 0013: Install Firefox and Google Chrome

**Status:** Accepted
**Date:** 2026-08-24

## Context

Web development benefits from testing in both Firefox and Google's Chrome
distribution. Firefox is packaged in Arch's official repositories. Google
Chrome is distributed for Arch through a community-maintained AUR recipe, whose
build instructions are not officially vetted by Arch.

## Decision

Install Firefox from Arch's official repositories and Google Chrome from the
`google-chrome` AUR package base. Record official and AUR selections in separate
manifests. Require manual review of AUR build files before invoking `makepkg`;
do not introduce an AUR helper yet.

## Consequences

- Both Gecko and Chromium-family browser engines are available for testing.
- Chrome installation and updates require an explicit AUR review and build.
- `base-devel` is installed as the standard AUR build prerequisite.
- Browser accounts, profiles, and credentials remain unmanaged local state.
