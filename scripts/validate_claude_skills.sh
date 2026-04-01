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

expect_contains() {
  local path=$1
  local pattern=$2
  rg -q --fixed-strings "$pattern" "$path" || note_error "Expected '$pattern' in $path"
}

expect_not_contains() {
  local path=$1
  local pattern=$2
  if rg -q --fixed-strings "$pattern" "$path"; then
    note_error "Unexpected '$pattern' in $path"
  fi
}

skill_count=0

for dir in "$repo_root"/kkstyle-*; do
  [[ -d "$dir" ]] || continue
  skill_count=$((skill_count + 1))

  expect_file "$dir/SKILL.md"
  expect_file "$dir/examples.md"
  expect_file "$dir/agents/openai.yaml"
  expect_file "$dir/references/layout-presets.md"
  expect_file "$dir/scripts/capture_card.sh"
  expect_file "$dir/scripts/image_to_data_uri.py"
  expect_file "$dir/assets/contact-code.png"
  expect_file "$dir/assets/kk-character.jpeg"

  expect_contains "$dir/SKILL.md" "description:"
  expect_contains "$dir/SKILL.md" "argument-hint:"
  expect_contains "$dir/SKILL.md" "disable-model-invocation: true"
  expect_contains "$dir/SKILL.md" '${CLAUDE_SKILL_DIR}'
  expect_contains "$dir/SKILL.md" '### `examples.md`'

  expect_not_contains "$dir/SKILL.md" './scripts/'
  expect_not_contains "$dir/SKILL.md" '使用 `assets/contact-code.png`'
  expect_not_contains "$dir/SKILL.md" '使用 `assets/kk-character.jpeg`'
  expect_not_contains "$dir/SKILL.md" 'image_to_data_uri.py assets/kk-character.jpeg'

  if [[ -d "$repo_root/.claude/skills" ]]; then
    [[ -e "$repo_root/.claude/skills/$(basename "$dir")" ]] || note_error "Missing project skill link: $repo_root/.claude/skills/$(basename "$dir")"
  fi
done

if [[ "$skill_count" -eq 0 ]]; then
  note_error "No kkstyle-* skill directories found."
fi

if [[ "$status" -eq 0 ]]; then
  echo "Validated $skill_count Claude Code skills successfully."
fi

exit "$status"
