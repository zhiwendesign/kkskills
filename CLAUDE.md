# KKStyle Skills Repo

This repository is a shareable Claude Code skill collection.

## Canonical source of truth

- Edit the top-level `kkstyle-*` directories.
- Treat `.claude/skills/*` as Claude Code discovery links, not the primary place to edit.
- Treat `plugins/kkstyle/skills/*` as generated plugin links, not the primary place to edit.

## Repository conventions

- Every skill must keep `SKILL.md` as the entrypoint.
- Use `${CLAUDE_SKILL_DIR}` whenever a skill references bundled scripts or assets in shell commands or generated HTML.
- Keep the skill's main instructions in `SKILL.md` and use `references/`, `assets/`, and `scripts/` for supporting files.
- Keep reusable invocation samples in `examples.md` so the main `SKILL.md` stays focused.
- These skills are intentionally manual-first in Claude Code. They are invoked with `/kkstyle-...` instead of auto-triggering in unrelated sessions.
- The plugin namespace is `kkstyle`, and the bundled marketplace name is `kkstyle-marketplace`.

## When adding or removing a skill

1. Create or remove the top-level `kkstyle-*` directory.
2. Refresh the Claude Code project links:

```bash
./scripts/install_claude_skills.sh --target ./.claude/skills --mode link --force
```

3. Refresh the plugin skill links:

```bash
./scripts/sync_claude_plugin.sh
```

4. Run the validators:

```bash
./scripts/validate_claude_skills.sh
./scripts/validate_claude_plugin.sh
```

5. Update [README.md](README.md) so the style matrix stays accurate.
