# Zsh user environment

The Zsh configuration is derived from the physical host and managed at `dotfiles/zsh/.zshrc`. It uses:

- Oh My Zsh with the Powerlevel10k theme;
- the `git` and `zsh-autosuggestions` plugins;
- JetBrains Mono Nerd Font glyphs for the Powerlevel10k prompt;
- `~/.local/bin` on `PATH` for user-local npm-installed command-line tools.

Third-party framework repositories are pinned by commit in `scripts/install-zsh-framework`, matching the revisions previously used on the physical host. Install the Zsh package manifest first, then run the framework and apply scripts as the target user:

```sh
sudo ./scripts/install-packages packages/20-shell.txt
./scripts/install-zsh-framework
./scripts/apply-zsh-config
sudo ./scripts/configure-shell mb
```

The tracked Powerlevel10k configuration reproduces the selected prompt. Rerun
the wizard at any time to customize it further:

```sh
p10k configure
```

The managed Kitty configuration selects `JetBrainsMono Nerd Font Mono`,
matching the font from the shell package manifest.

The apply script links `~/.zshrc`, `~/.zprofile`, and the wizard-generated
`~/.p10k.zsh` to their repository-managed files. It safely replaces an
identical regular copy and refuses to overwrite a different existing file.

The login profile starts Hyprland through `start-hyprland` only after a local
login on `tty1`. It does not affect SSH, secondary TTYs, or terminals inside the
graphical session. This keeps authentication interactive while making the
desktop the normal post-login environment and leaves another TTY available for
recovery. It exports `~/.local/bin` before starting Hyprland so repository-owned
session helpers are available to the compositor at startup; `.zshrc` adds the
same path only when it is not already present.
