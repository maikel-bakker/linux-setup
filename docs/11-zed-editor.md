# Zed editor

## Selection

Use Zed as the first graphical code editor. Install Arch's signed `zed` package
instead of an upstream shell installer or AUR variant. Zed supports native
Wayland and requires a working Vulkan driver.

Editor accounts, authentication tokens, project history, and machine-local
state are not part of this repository.

## Graphics driver boundary

The editor manifest is hardware-independent. Install a Vulkan driver appropriate
for each machine alongside it:

- `arch-lab` uses `vulkan-virtio`, recorded separately in
  `packages/lab/43-zed-editor.txt`;
- the physical AMD host will use `vulkan-radeon` when this layer is adopted
  there.

Do not install every Vulkan provider or copy the VM-specific choice to the
physical host.

## Install in the lab

Install both the editor and the lab-specific driver in one transaction:

```sh
sudo ./scripts/install-packages \
  packages/43-zed-editor.txt \
  packages/lab/43-zed-editor.txt
```

Then launch Zed through Rofi. Confirm that it opens without a Vulkan error,
renders correctly under Wayland, opens a local repository, starts its integrated
terminal, and detects the existing Node.js toolchain.

## Lab result

Installed in `arch-lab` on 2026-08-24. Pacman installed Zed 1.12.1 and
`vulkan-virtio` 26.1.5, Rofi found the packaged desktop entry, and the Arch CLI
is available as `/usr/bin/zeditor`.

Native rendering cannot be validated in the current VM configuration. Zed's log
shows that Virtio Vulkan initialization fails and it falls back to software
rendering through llvmpipe, triggering the unsupported-GPU warning. Enabling
host-side accelerated Virtio/Venus graphics solely for this test is not worth
the additional lab complexity. Treat this as a VM limitation, not a successful
graphics test.

Before adopting Zed on the physical AMD host, install `vulkan-radeon` and require
`vulkaninfo --summary`, `vkcube-wayland`, and Zed itself to render without a
software-emulation warning.

## Managed configuration

Zed's user-editable configuration is managed as one directory:

```text
dotfiles/zed/
├── AGENTS.md
└── settings.json
```

Link the local configuration directory to the repository after closing Zed:

```sh
./scripts/apply-zed-config
```

If `~/.config/zed` already exists, the script moves it to a dated sibling
backup (for example, `zed.pre-linux-setup-20260824T120000`) before making the
symlink. It refuses to replace a symlink that points somewhere else.

The managed configuration intentionally includes editor preferences and Zed
agent preferences. The agent permissions include narrow, project-specific
allow rules for the existing `mb-apps` test paths and ordinary `npm run`,
`node`, and `git` commands. Review these rules before adding new always-allow
patterns: they are authorization, not merely appearance settings.

Zed account credentials, extension data, databases, logs, project history, and
other machine-local state remain outside this configuration directory and must
not be added to Git. `settings_backup.json` from the original local directory
is deliberately not imported; Git history is the managed-settings backup.

To change settings, edit the linked file through Zed or directly in the
repository, inspect `git diff`, and commit the result. Pull and run the script
on another machine to adopt the same configuration.

## Deferred configuration

- Language servers, formatters, and project-specific tooling.
- Zed account login and a Secret Service provider.
- Hyprland development workspace rules and launch scripts.
