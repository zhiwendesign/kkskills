#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
status=0

note_error() {
  echo "ERROR: $*" >&2
  status=1
}

expect_file() {
  local path=$1
  [[ -e "$path" ]] || note_error "Missing file: $path"
}

plugin_root="$repo_root/plugins/kkstyle"
skills_root="$plugin_root/skills"
marketplace_file="$repo_root/.claude-plugin/marketplace.json"
plugin_file="$plugin_root/.claude-plugin/plugin.json"

expect_file "$marketplace_file"
expect_file "$plugin_file"
expect_file "$plugin_root/README.md"
expect_file "$plugin_root/CHANGELOG.md"
expect_file "$repo_root/scripts/sync_claude_plugin.sh"
expect_file "$repo_root/scripts/build_claude_marketplace.sh"

python3 - <<'PY' "$marketplace_file" "$plugin_file" || status=1
import json
import sys

marketplace_path, plugin_path = sys.argv[1:3]

with open(marketplace_path, "r", encoding="utf-8") as f:
    marketplace = json.load(f)
with open(plugin_path, "r", encoding="utf-8") as f:
    plugin = json.load(f)

if marketplace.get("name") != "kkstyle-marketplace":
    raise SystemExit("marketplace name must be kkstyle-marketplace")
plugins = marketplace.get("plugins", [])
if len(plugins) != 1 or plugins[0].get("name") != "kkstyle":
    raise SystemExit("marketplace must expose exactly one plugin named kkstyle")
if plugins[0].get("source") != "kkstyle":
    raise SystemExit("marketplace plugin source must be kkstyle")
if plugin.get("name") != "kkstyle":
    raise SystemExit("plugin name must be kkstyle")
if "version" not in plugin or "description" not in plugin:
    raise SystemExit("plugin manifest must include version and description")
PY

top_level_skills=0
plugin_skills=0

for dir in "$repo_root"/kkstyle-*; do
  [[ -d "$dir" && -f "$dir/SKILL.md" ]] || continue
  top_level_skills=$((top_level_skills + 1))
  skill_name=$(basename "$dir")
  if [[ ! -e "$skills_root/$skill_name" ]]; then
    note_error "Missing plugin skill entry: $skills_root/$skill_name"
    continue
  fi
done

if [[ -d "$skills_root" ]]; then
  while IFS= read -r -d '' entry; do
    plugin_skills=$((plugin_skills + 1))
  done < <(find "$skills_root" -mindepth 1 -maxdepth 1 -print0)
fi

if [[ "$top_level_skills" -ne "$plugin_skills" ]]; then
  note_error "Plugin skill count ($plugin_skills) does not match top-level skill count ($top_level_skills)"
fi

if [[ "$status" -eq 0 ]]; then
  echo "Validated Claude Code plugin structure successfully."
fi

exit "$status"
