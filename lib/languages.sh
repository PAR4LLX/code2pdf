#!/usr/bin/env bash
set -euo pipefail

declare -A LANGUAGES=(
  ["py"]="python"
  ["java"]="java"
  ["c"]="c"
  ["cpp"]="cpp"
  ["js"]="javascript"
  ["html"]="html"
  ["css"]="css"
  ["rb"]="ruby"
  ["sh"]="shell"
  ["cs"]="csharp"
)

language_for_ext() {
  local ext="$1"
  echo "${LANGUAGES[$ext]:-}"
}
