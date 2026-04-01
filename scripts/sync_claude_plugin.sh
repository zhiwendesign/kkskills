#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
plugin_root="$repo_root/plugins/kkstyle"
skills_root="$plugin_root/skills"

mkdir -p "$plugin_root/.claude-plugin" "$skills_root"

find "$skills_root" -mindepth 1 -maxdepth 1 -exec rm -rf {} +

count=0
for dir in "$repo_root"/kkstyle-*; do
  [[ -d "$dir" && -f "$dir/SKILL.md" ]] || continue
  skill_name=$(basename "$dir")
  ln -s "../../../$skill_name" "$skills_root/$skill_name"
  count=$((count + 1))
done

echo "Synced $count skills into $plugin_root"
