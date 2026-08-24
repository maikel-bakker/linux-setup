# Web development

## JavaScript runtime

Install the distribution-supported Node.js runtime and npm from the web-development package manifest:

```sh
sudo ./scripts/install-packages packages/30-web-development.txt
```

This deliberately starts with one system-wide Node.js version. Introduce a version manager only when a project has a real need for multiple Node releases or toolchain isolation.

## Codex CLI

Install global npm tools into `~/.local`, rather than a directory managed by pacman:

```sh
./scripts/install-global-npm-packages npm/global-packages.txt
codex --version
codex login
```

The Codex CLI package is `@openai/codex`. Authentication is interactive and local; no API keys, OAuth refresh tokens, or Codex configuration secrets belong in this repository. The package name is tracked in the manifest; update it intentionally with the installer script.

The installer sets npm's user prefix to `~/.local`, and the managed Zsh
configuration places `~/.local/bin` on `PATH`. It never writes global npm tools
into pacman-owned directories or requires `sudo npm`.

## Lab validation

Validated in `arch-lab` on 2026-08-24:

- Node.js 26.5.0 and npm 12.0.1 are installed from Arch packages;
- npm's global prefix is `/home/mb/.local`;
- `@openai/codex` 0.149.1 is installed in the user prefix;
- `codex` resolves to `/home/mb/.local/bin/codex` and starts successfully.

Authentication and Codex configuration remain local user state. A fresh rebuild
should run `codex login` interactively; it must not copy `~/.codex` or any token
into this repository.
