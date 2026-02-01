#!/usr/bin/env bash
set -euo pipefail

detect_distro() {
  local distro_name=""

  if [[ -f /etc/os-release ]]; then
    # shellcheck disable=SC1091
    . /etc/os-release
    distro_name="${NAME:-}"
  elif [[ -f /etc/lsb-release ]]; then
    # shellcheck disable=SC1091
    . /etc/lsb-release
    distro_name="${DISTRIB_ID:-}"
  else
    echo ""
    return 0
  fi

  echo "$distro_name"
}
