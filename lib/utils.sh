#!/usr/bin/env bash
set -euo pipefail

die() {
  echo "Error: $*" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || die "Missing required command: $1"
}

escape_latex() {
  # Escape underscores (expand later if you want)
  echo "$1" | sed 's/_/\\_/g'
}
