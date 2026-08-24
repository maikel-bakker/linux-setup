# 0016: Manage Zed configuration in the setup repository

**Status:** Accepted
**Date:** 2026-08-24

## Context

Zed is installed as the graphical editor, but its editor and agent preferences
need a reproducible, reviewable home that can be synchronized between machines.
Zed also maintains credentials, databases, extension data, logs, and history
that must remain local.

## Decision

Keep the user-editable Zed configuration in `dotfiles/zed` and symlink the
whole `~/.config/zed` directory with `scripts/apply-zed-config`. Track
`settings.json` and `AGENTS.md`, including current editor and agent
preferences. Do not track the obsolete local settings backup or credential and
application-state stores.

## Consequences

- Zed configuration changes appear as Git changes immediately.
- New files that Zed creates under the linked directory are visible as
  untracked files and must be reviewed before committing.
- The apply script preserves a recoverable dated copy of a pre-existing local
  configuration directory.
- Agent permission rules are synchronized across machines and require the same
  review standard as other authorization changes.
