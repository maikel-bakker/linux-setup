# Zsh user environment

The Zsh configuration is derived from the physical host and managed at `dotfiles/zsh/.zshrc`. It uses:

- Oh My Zsh with the `robbyrussell` theme;
- the `git` and `zsh-autosuggestions` plugins;
- `~/.local/bin` on `PATH` for user-local npm-installed command-line tools.

Third-party framework repositories are pinned by commit in `scripts/install-zsh-framework`, matching the revisions previously used on the physical host. Install the Zsh package manifest first, then run the framework and apply scripts as the target user:

```sh
sudo ./scripts/install-packages packages/20-shell.txt
./scripts/install-zsh-framework
./scripts/apply-zsh-config
sudo ./scripts/configure-shell mb
```

The apply script creates a symlink from `~/.zshrc` to the repository-managed file. It safely replaces an identical regular copy; it refuses to overwrite a different existing file.
