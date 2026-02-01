#!/usr/bin/env bash
set -euo pipefail

detect_distro() {
  # Returns: arch | debian | redhat | unknown
  local id=""
  local id_like=""

  if [[ -f /etc/os-release ]]; then
    # shellcheck disable=SC1091
    . /etc/os-release

    id="${ID:-}"
    id_like="${ID_LIKE:-}"

    # normalize
    id="${id,,}"
    id_like="${id_like,,}"
  fi

  # Combine both fields for matching
  local combined="$id $id_like"

  # Arch family
  if [[ "$combined" == *"arch"* || "$combined" == *"endeavouros"* || "$combined" == *"manjaro"* ]]; then
    echo "arch"
    return 0
  fi

  # Debian family
  if [[ "$combined" == *"debian"* || "$combined" == *"ubuntu"* || "$combined" == *"mint"* || "$combined" == *"pop"* ]]; then
    echo "debian"
    return 0
  fi

  # Red Hat family
  if [[ "$combined" == *"rhel"* || "$combined" == *"fedora"* || "$combined" == *"centos"* || "$combined" == *"rocky"* || "$combined" == *"alma"* ]]; then
    echo "redhat"
    return 0
  fi

  # Fallback: detect by package manager
  if command -v pacman >/dev/null 2>&1; then
    echo "arch"
    return 0
  fi

  if command -v apt-get >/dev/null 2>&1; then
    echo "debian"
    return 0
  fi

  if command -v dnf >/dev/null 2>&1; then
    echo "redhat"
    return 0
  fi

  echo "unknown"
}

