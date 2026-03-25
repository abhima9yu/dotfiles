#!/usr/bin/env bash
# Bootstrap a fresh Mac: install Homebrew (bash only), then ruby+git, fetch dotfiles, run setup_new_mac.sh.
# Typical: curl -fsSL https://raw.githubusercontent.com/USER/dotfiles/main/scripts/bootstrap.sh | bash
# Set DOTFILES_GIT_URL (or DOTFILES_ZIP_URL) when piping so clone/unzip knows where to fetch.

set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This script targets macOS only." >&2
  exit 1
fi

DOTFILES_DIR="${DOTFILES_DIR:-"$HOME/dotfiles"}"
DOTFILES_BRANCH="${DOTFILES_BRANCH:-main}"

brew_shellenv() {
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  else
    echo "Homebrew not found and install did not place brew in a standard path." >&2
    exit 1
  fi
}

if ! command -v brew >/dev/null 2>&1; then
  echo ">>> Installing Homebrew (interactive prompts possible)..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew_shellenv

echo ">>> brew install ruby git"
brew install ruby git

prepend_brew_ruby_path() {
  local prefix
  prefix="$(brew --prefix ruby)"
  export PATH="${prefix}/bin:${PATH}"
}

prepend_brew_ruby_path

fetch_dotfiles() {
  if [[ -f "$DOTFILES_DIR/bashrc" ]]; then
    echo ">>> Dotfiles already present at $DOTFILES_DIR (skipping fetch)."
    if [[ "${GIT_PULL:-}" == "1" ]] && [[ -d "$DOTFILES_DIR/.git" ]]; then
      echo ">>> GIT_PULL=1: git pull"
      git -C "$DOTFILES_DIR" pull --ff-only
    fi
    return
  fi

  if [[ -n "${DOTFILES_ZIP_URL:-}" ]]; then
    echo ">>> Fetching dotfiles archive..."
    local tmp extract_root
    tmp="$(mktemp -d)"
    curl -fsSL "${DOTFILES_ZIP_URL}" -o "$tmp/archive.zip"
    unzip -q "$tmp/archive.zip" -d "$tmp/out"
    extract_root="$(find "$tmp/out" -mindepth 1 -maxdepth 1 -type d | head -1)"
    if [[ -z "$extract_root" ]]; then
      rm -rf "$tmp"
      echo "Archive had no top-level directory." >&2
      exit 1
    fi
    mkdir -p "$(dirname "$DOTFILES_DIR")"
    mv "$extract_root" "$DOTFILES_DIR"
    rm -rf "$tmp"
    return
  fi

  if [[ -n "${DOTFILES_GIT_URL:-}" ]]; then
    echo ">>> Cloning dotfiles..."
    mkdir -p "$(dirname "$DOTFILES_DIR")"
    git clone --branch "${DOTFILES_BRANCH}" --depth 1 "${DOTFILES_GIT_URL}" "${DOTFILES_DIR}"
    return
  fi

  echo "No dotfiles at $DOTFILES_DIR and neither DOTFILES_GIT_URL nor DOTFILES_ZIP_URL is set." >&2
  echo "Example: DOTFILES_GIT_URL=https://github.com/you/dotfiles.git ${0##*/}" >&2
  exit 1
}

fetch_dotfiles

setup_script="${DOTFILES_DIR}/scripts/setup_new_mac.sh"
if [[ ! -f "$setup_script" ]]; then
  echo "Missing $setup_script" >&2
  exit 1
fi

echo ">>> Running setup_new_mac.sh..."
exec bash "$setup_script"
