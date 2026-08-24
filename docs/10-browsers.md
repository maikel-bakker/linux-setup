# Web browsers

## Selection

Install both Firefox and Google Chrome. Firefox provides an open-source browser
from Arch's signed official repositories. Chrome is useful for testing the
Google-distributed Chromium build and browser-specific web behavior, but its
Arch packaging is a user-maintained AUR recipe.

Browser profiles, sync credentials, cookies, history, and extension data are
local state and must never be committed.

## Firefox

Install Firefox and the standard AUR build toolchain from the official
repositories:

```sh
sudo ./scripts/install-packages packages/42-browsers.txt
```

## Google Chrome

The AUR is untrusted user-produced content. The repository records the selected
package base in `packages/aur/42-browsers.txt`, but deliberately does not run an
AUR helper or build an unreviewed recipe automatically.

Prepare a fresh review directory:

```sh
./scripts/prepare-aur-package google-chrome
```

Read the downloaded `PKGBUILD` and every accompanying file. Confirm its sources,
checksums, install actions, and recent Git history. Then verify, build, and
install that unchanged checkout as the normal user:

```sh
./scripts/prepare-aur-package --install google-chrome
```

The install mode confirms the AUR origin, refuses modified tracked build files,
runs `makepkg --verifysource`, and then invokes `makepkg -si`. Pacman still asks
for authorization when the completed Arch package is installed.

Repeat the review when the AUR recipe changes. Do not commit downloaded AUR
files, built packages, browser profiles, or Google credentials.

## Validation

Launch both browsers through Rofi. Confirm native Wayland rendering, audio,
downloads through the portal, and that each browser can reach a local web
development server.

Firefox 153.0-1 and Google Chrome 151.0.7922.173-1 were installed in `arch-lab`
on 2026-08-24. Chrome was built from reviewed AUR commit `0617151`, which
repackaged Google's checksum-pinned stable-channel binary.
