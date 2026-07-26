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
codex --login
```

The Codex CLI package is `@openai/codex`. Authentication is interactive and local; no API keys, OAuth refresh tokens, or Codex configuration secrets belong in this repository. The package name is tracked in the manifest; update it intentionally with the installer script.
