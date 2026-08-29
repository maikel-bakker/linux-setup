# Web browsers

## Selection

Install Firefox, Google Chrome, and Brave. Firefox provides an open-source
browser from Arch's signed official repositories. Chrome is useful for testing
the Google-distributed Chromium build and browser-specific web behavior. Brave
provides a Chromium-family browser with integrated tracker and advertisement
blocking. Both proprietary Chromium-family binaries use review-first AUR
recipes because Arch does not distribute them from its signed repositories.

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

## Brave

Brave's upstream Linux documentation directs Arch users to the `brave-bin` AUR
package. Prepare and inspect its packaging separately from Chrome:

```sh
./scripts/prepare-aur-package brave-bin
```

Review the current `PKGBUILD`, `.SRCINFO`, desktop entry, launcher, every other
tracked file, and recent Git history. Confirm that the binary source comes from
Brave's official release infrastructure and matches its pinned checksum. Then
verify, build, and install the unchanged checkout:

```sh
./scripts/prepare-aur-package --install brave-bin
```

Repeat the review whenever the AUR recipe changes. Do not commit the downloaded
checkout, built packages, browser profiles, Brave Rewards state, or credentials.

## Validation

Launch all three browsers through Rofi. Confirm native Wayland rendering, audio,
downloads through the portal, and that each browser can reach a local web
development server.

Firefox 153.0-1 and Google Chrome 151.0.7922.173-1 were installed in `arch-lab`
on 2026-08-24. Chrome was built from reviewed AUR commit `0617151`, which
repackaged Google's checksum-pinned stable-channel binary.

Firefox 154.0.1-1, Google Chrome 152.0.7977.64-1, and Brave 1:1.94.117-1 were
installed on the physical workstation on 2026-08-29. Chrome was built from
reviewed AUR commit `1cf56b5`; Brave was built from reviewed AUR commit
`7b85edf`. Both downloaded upstream binaries passed their pinned checksum
verification. Graphical launch and portal validation remain pending.
