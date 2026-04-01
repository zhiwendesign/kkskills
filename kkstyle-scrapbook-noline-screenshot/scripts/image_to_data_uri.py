#!/usr/bin/env python3

import base64
import mimetypes
import pathlib
import sys


def main() -> int:
    if len(sys.argv) != 2:
        print("Usage: image_to_data_uri.py <image-path>", file=sys.stderr)
        return 1

    path = pathlib.Path(sys.argv[1]).expanduser().resolve()
    if not path.is_file():
        print(f"Image not found: {path}", file=sys.stderr)
        return 1

    mime_type, _ = mimetypes.guess_type(path.name)
    mime_type = mime_type or "application/octet-stream"
    encoded = base64.b64encode(path.read_bytes()).decode("ascii")
    print(f"data:{mime_type};base64,{encoded}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
