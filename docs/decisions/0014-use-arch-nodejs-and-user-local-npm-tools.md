# 0014: Use Arch Node.js with user-local global npm tools

**Status:** Accepted
**Date:** 2026-08-24

## Context

The initial web-development layer needs Node.js, npm, and the Codex CLI. Pacman
owns system package paths, so running global npm installs into `/usr` would mix
two package managers and require unnecessary root access. A Node version manager
adds complexity before a project actually needs multiple runtime versions.

## Decision

Install `nodejs` and `npm` from Arch's repositories. Set npm's global prefix to
`~/.local`, expose `~/.local/bin` through the managed Zsh configuration, and
install the Codex CLI from the tracked `@openai/codex` npm package. Keep Codex
authentication interactive and outside Git.

## Consequences

- Pacman owns the runtime while npm owns user-local command-line tools.
- Installing or updating tracked global npm tools does not require root.
- The system initially has one rolling-release Node.js version.
- Projects that require another Node version will need a later version-manager
  decision.
- Codex login state and configuration are not reproduced from this repository.
