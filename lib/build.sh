#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=/dev/null
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/utils.sh"

build_pdf() {
  local tex_file="$1"
  local final_pdf="$2"

  require_command pdflatex

  for _ in 1 2; do
    pdflatex -shell-escape "$tex_file" >/dev/null
  done

  local pdf_file="${tex_file%.tex}.pdf"
  [[ -f "$pdf_file" ]] || die "Expected PDF not found: $pdf_file"

  mv -f "$pdf_file" "$final_pdf"
}

cleanup_build_artifacts() {
  local tex_file="$1"
  local base="${tex_file%.tex}"

  rm -rf \
    "$base.aux" "$base.out" "$base.toc" "$base.log" \
    "_minted-$base" \
    "$tex_file"
}
