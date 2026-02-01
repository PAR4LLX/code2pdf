#!/usr/bin/env bash
set -euo pipefail

install_debian_packages() {
  local packages="$1"
  for package in $packages; do
    if ! dpkg -l | grep -q "^ii  $package"; then
      echo "Installing $package..."
      sudo apt-get update
      sudo apt-get install -y "$package"
    fi
  done
}

install_redhat_packages() {
  local packages="$1"
  for package in $packages; do
    if ! rpm -q "$package" >/dev/null 2>&1; then
      echo "Installing $package..."
      sudo dnf install -y "$package"
    fi
  done
}

install_arch_packages() {
  local packages="$1"
  for package in $packages; do
    if ! pacman -Q "$package" >/dev/null 2>&1; then
      echo "Installing $package..."
      sudo pacman -Sy --noconfirm "$package"
    fi
  done
}

install_required_packages() {
  local distro_family="$1"

  case "$distro_family" in
    debian)
      install_debian_packages "texlive pdflatex python3-pygments"
      ;;
    redhat)
      install_redhat_packages "texlive pdflatex python3-pygments"
      ;;
    arch)
      # Works for Arch + EndeavourOS + other Arch-likes
      install_arch_packages "texlive-core texlive-bin texlive-latexextra python-pygments"
      ;;
    *)
      echo "Unsupported/unknown distro family: $distro_family"
      echo "Skipping package install. Ensure TeX + Pygments are installed."
      ;;
  esac
}

