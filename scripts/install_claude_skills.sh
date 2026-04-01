#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Install KKStyle skills into a Claude Code skills directory.

Usage:
  ./scripts/install_claude_skills.sh [--target DIR] [--mode link|copy] [--force]

Options:
  --target DIR   Install into DIR. Defaults to ~/.claude/skills
  --mode MODE    Install mode: link or copy. Defaults to link
  --force        Replace existing destinations with the same skill name
  -h, --help     Show this help text

Examples:
  ./scripts/install_claude_skills.sh
  ./scripts/install_claude_skills.sh --target ./.claude/skills --mode link --force
  ./scripts/install_claude_skills.sh --target ~/.claude/skills --mode copy
EOF
}

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
target_dir="${HOME}/.claude/skills"
mode="link"
force="false"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      shift
      [[ $# -gt 0 ]] || { echo "Missing value for --target" >&2; exit 1; }
      target_dir="$1"
      ;;
    --mode)
      shift
      [[ $# -gt 0 ]] || { echo "Missing value for --mode" >&2; exit 1; }
      mode="$1"
      ;;
    --force)
      force="true"
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
  shift
done

case "$mode" in
  link|copy)
    ;;
  *)
    echo "Unsupported mode: $mode" >&2
    echo "Supported modes: link, copy" >&2
    exit 1
    ;;
esac

mkdir -p "$target_dir"

relative_link_target() {
  python3 - "$1" "$2" <<'PY'
import os
import sys

source = os.path.abspath(sys.argv[1])
target_parent = os.path.abspath(sys.argv[2])
print(os.path.relpath(source, target_parent))
PY
}

skills=()
for dir in "$repo_root"/kkstyle-*; do
  [[ -d "$dir" && -f "$dir/SKILL.md" ]] || continue
  skills+=("$dir")
done

if [[ ${#skills[@]} -eq 0 ]]; then
  echo "No skill directories found under $repo_root" >&2
  exit 1
fi

installed=0
skipped=0

for src in "${skills[@]}"; do
  skill_name=$(basename "$src")
  dest="$target_dir/$skill_name"

  if [[ -e "$dest" || -L "$dest" ]]; then
    if [[ "$force" == "true" ]]; then
      rm -rf "$dest"
    else
      echo "Skipping existing $dest" >&2
      skipped=$((skipped + 1))
      continue
    fi
  fi

  case "$mode" in
    link)
      parent_dir=$(dirname "$dest")
      ln -s "$(relative_link_target "$src" "$parent_dir")" "$dest"
      ;;
    copy)
      cp -R "$src" "$dest"
      ;;
  esac

  installed=$((installed + 1))
done

echo "Installed $installed skills into $target_dir using $mode mode."
if [[ "$skipped" -gt 0 ]]; then
  echo "Skipped $skipped existing destinations. Re-run with --force to replace them."
fi
