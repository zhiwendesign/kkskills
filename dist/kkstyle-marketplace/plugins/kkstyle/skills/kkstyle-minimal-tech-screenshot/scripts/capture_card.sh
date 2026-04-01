#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 3 ]]; then
  echo "Usage: $0 <input.html> <output.png> <ratio>" >&2
  exit 1
fi

input_path=$1
output_path=$2
ratio_key=$3

case "$ratio_key" in
  "3:4")
    width=1500
    height=2000
    ;;
  "4:3")
    width=2000
    height=1500
    ;;
  "1:1")
    width=1800
    height=1800
    ;;
  "16:9")
    width=1920
    height=1080
    ;;
  "9:16")
    width=1080
    height=1920
    ;;
  *)
    echo "Unsupported ratio: $ratio_key" >&2
    echo "Supported ratios: 3:4, 4:3, 1:1, 16:9, 9:16" >&2
    exit 1
    ;;
esac

if [[ ! -f "$input_path" ]]; then
  echo "Input HTML not found: $input_path" >&2
  exit 1
fi

resolve_chrome() {
  if [[ -n "${CHROME_BIN:-}" && -x "${CHROME_BIN}" ]]; then
    printf '%s\n' "${CHROME_BIN}"
    return 0
  fi

  local candidate
  for candidate in \
    "google-chrome" \
    "chromium" \
    "chromium-browser" \
    "chrome" \
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
  do
    if command -v "$candidate" >/dev/null 2>&1; then
      command -v "$candidate"
      return 0
    fi
    if [[ -x "$candidate" ]]; then
      printf '%s\n' "$candidate"
      return 0
    fi
  done

  return 1
}

chrome_bin=$(resolve_chrome || true)

if [[ -z "$chrome_bin" ]]; then
  echo "Chrome or Chromium binary not found. Set CHROME_BIN if needed." >&2
  exit 1
fi

mkdir -p "$(dirname "$output_path")"

abs_input_path=$(cd "$(dirname "$input_path")" && pwd)/$(basename "$input_path")
abs_output_path=$(cd "$(dirname "$output_path")" && pwd)/$(basename "$output_path")
input_url="file://${abs_input_path}"

run_capture() {
  local headless_flag=$1

  "$chrome_bin" \
    "$headless_flag" \
    --disable-gpu \
    --no-sandbox \
    --hide-scrollbars \
    --run-all-compositor-stages-before-draw \
    --virtual-time-budget=5000 \
    --force-device-scale-factor=1 \
    --window-size="${width},${height}" \
    --screenshot="$abs_output_path" \
    "$input_url"
}

if ! run_capture --headless=new; then
  run_capture --headless
fi

echo "Saved screenshot to $abs_output_path"
