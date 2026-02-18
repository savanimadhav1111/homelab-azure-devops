#!/usr/bin/env bash
set -Eeuo pipefail

trap 'echo "[ERROR] line=$LINENO exit_code=$? command=${BASH_COMMAND}" >&2' ERR

PACKAGES_DEFAULT=("git" "curl" "jq" "unzip")
if [[ "$#" -gt 0 ]]; then
  PACKAGES=("$@")
else
  PACKAGES=("${PACKAGES_DEFAULT[@]}")
fi

require_root() {
  if [[ "${EUID}" -ne 0 ]]; then
    echo "[INFO] Re-running with sudo..."
    exec sudo bash "$0" "${PACKAGES[@]}"
  fi
}

detect_pkg_manager() {
  if command -v apt-get >/dev/null 2>&1; then
    echo "apt"
    return
  fi
  if command -v dnf >/dev/null 2>&1; then
    echo "dnf"
    return
  fi
  if command -v yum >/dev/null 2>&1; then
    echo "yum"
    return
  fi
  echo "none"
}

is_installed() {
  local pkg="$1"
  case "${PKG_MANAGER}" in
    apt) dpkg -s "${pkg}" >/dev/null 2>&1 ;;
    dnf|yum) rpm -q "${pkg}" >/dev/null 2>&1 ;;
    *) return 1 ;;
  esac
}

install_pkg() {
  local pkg="$1"
  case "${PKG_MANAGER}" in
    apt) apt-get install -y "${pkg}" ;;
    dnf) dnf install -y "${pkg}" ;;
    yum) yum install -y "${pkg}" ;;
    *) echo "[ERROR] Unsupported package manager: ${PKG_MANAGER}" >&2; return 1 ;;
  esac
}

echo "[INFO] Starting package bootstrap"
echo "[INFO] Requested packages: ${PACKAGES[*]}"

require_root

PKG_MANAGER="$(detect_pkg_manager)"
if [[ "${PKG_MANAGER}" == "none" ]]; then
  echo "[ERROR] No supported package manager found (apt/dnf/yum)." >&2
  exit 1
fi

echo "[INFO] Package manager detected: ${PKG_MANAGER}"

if [[ "${PKG_MANAGER}" == "apt" ]]; then
  echo "[INFO] apt-get update"
  apt-get update -y
fi

INSTALLED=()
SKIPPED=()

for pkg in "${PACKAGES[@]}"; do
  if is_installed "${pkg}"; then
    echo "[SKIP] ${pkg} already installed"
    SKIPPED+=("${pkg}")
    continue
  fi
  echo "[INSTALL] ${pkg}"
  install_pkg "${pkg}"
  INSTALLED+=("${pkg}")
done

echo "[INFO] Completed package bootstrap"
echo "[INFO] Installed: ${INSTALLED[*]:-none}"
echo "[INFO] Skipped: ${SKIPPED[*]:-none}"
