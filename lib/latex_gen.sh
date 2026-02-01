#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=/dev/null
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/utils.sh"

write_preamble() {
  local out="$1"

  {
    echo '\documentclass{article}'
    echo '\title{OOP Lab 1}'
    echo '\date{\today}'
    echo '\author{Dhanveer Ramnauth}'
    echo '\usepackage[ddmmyyyy]{datetime}'
    echo '\usepackage{minted}'
    echo '\usepackage{caption}'
    echo '\usepackage{float}'
    echo '\usepackage[top=1.5cm, bottom=2cm, left=1.5cm, right=2cm]{geometry}'
    echo '\usepackage{titling}'
    echo '\usepackage{hyperref}'
    echo '\usepackage{tocloft}'
    echo '\usepackage{titlesec}'
    echo '\titlespacing*{\section} {0pt} {0pt} {1.5em}'
    echo '\renewcommand\maketitlehooka{\null\mbox{}\vfill}'
    echo '\renewcommand\maketitlehookd{\vfill\null}'
    echo '\newcommand{\includeminted}[3]{\section{#1}\inputminted[linenos, breaklines]{#2}{#3}}'
    echo '\begin{document}'
    echo '\begin{titlingpage}'
    echo '\maketitle'
    echo '\end{titlingpage}'
    echo '\tableofcontents'
    echo '\newpage'
  } > "$out"
}

append_files() {
  local out="$1"
  local folder="$2"
  local ext="$3"
  local lang="$4"

  find "$folder" -type f -name "*.$ext" | while read -r file; do
    local filename
    filename="$(basename "$file")"
    local filename_escaped
    filename_escaped="$(escape_latex "$filename")"
    echo "\\includeminted{$filename_escaped}{$lang}{$file}" >> "$out"
  done
}

finish_document() {
  local out="$1"
  echo '\end{document}' >> "$out"
}

generate_latex_file() {
  local output_tex="$1"
  local folder_path="$2"
  local file_ext="$3"
  local language="$4"

  write_preamble "$output_tex"
  append_files "$output_tex" "$folder_path" "$file_ext" "$language"
  finish_document "$output_tex"
}
