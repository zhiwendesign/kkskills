#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
output_dir="${1:-$repo_root/dist/kkstyle-marketplace}"

mkdir -p "$repo_root/dist"
rm -rf "$output_dir"
mkdir -p "$output_dir"

cp -R "$repo_root/.claude-plugin" "$output_dir/.claude-plugin"
mkdir -p "$output_dir/plugins"
cp -R -L "$repo_root/plugins/kkstyle" "$output_dir/plugins/kkstyle"
cp "$repo_root/README.md" "$output_dir/README.md"

echo "Built Claude Code marketplace bundle at $output_dir"
echo "To test locally:"
echo "  /plugin marketplace add $output_dir"
echo "  /plugin install kkstyle@kkstyle-marketplace"
