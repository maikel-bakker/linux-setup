# Zsh user environment

The Zsh configuration is derived from the physical host and managed at `dotfiles/zsh/.zshrc`. It uses:

- Oh My Zsh with the `robbyrussell` theme;
- the `git` and `zsh-autosuggestions` plugins;
- an optional Homebrew environment initialization;
- an optional `codex` alias backed by `npx`.

Third-party framework repositories are pinned by commit in `scripts/install-zsh-framework`, matching the revisions previously used on the physical host. Install the Zsh package manifest first, then run the framework and apply scripts as the target user:

```sh
sudo ./scripts/install-packages packages/20-shell.txt
./scripts/install-zsh-framework
./scripts/apply-zsh-config
sudo ./scripts/configure-shell mb
```

The apply script creates a symlink from `~/.zshrc` to the repository-managed file. It refuses to overwrite a regular existing file.
