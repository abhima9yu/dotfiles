#!/usr/bin/env bash
# Setup a new Mac: run install scripts and add dotfiles bashrc to ~/.zshrc.
# Run from the dotfiles repo root: ./scripts/setup_new_mac.sh

set -e

# Resolve dotfiles root (directory containing bashrc)
if [[ -n "${BASH_SOURCE[0]}" ]]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  DOTFILES_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
else
  DOTFILES_ROOT="${DOTFILES_ROOT:-$HOME/dotfiles}"
fi

BASHRC_LINE="[[ -f $DOTFILES_ROOT/bashrc ]] && . $DOTFILES_ROOT/bashrc"

echo "Using DOTFILES_ROOT=$DOTFILES_ROOT"
echo "---"

# 1. Homebrew (required for most other installs)
echo ">>> Install Homebrew"
ruby "$DOTFILES_ROOT/scripts/install_brew.rb"
# Ensure brew is on PATH for this script (e.g. Apple Silicon post-install)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
echo ""

# 2. Git
echo ">>> Install Git"
ruby "$DOTFILES_ROOT/scripts/install_git.rb"
echo ""

# 3. Ruby (needed to run remaining Ruby scripts)
echo ">>> Install Ruby"
ruby "$DOTFILES_ROOT/scripts/install_ruby.rb"
echo ""

# 4–10. Other tools
for script in install_rbenv install_rails install_docker install_aws install_heroku install_ohmyzsh install_vscode; do
  echo ">>> $script"
  ruby "$DOTFILES_ROOT/scripts/${script}.rb" || true
  echo ""
done

# Add bashrc to ~/.zshrc if not already present
if grep -qF "$DOTFILES_ROOT/bashrc" ~/.zshrc 2>/dev/null; then
  echo ">>> bashrc already referenced in ~/.zshrc, skipping."
else
  echo ">>> Adding bashrc to ~/.zshrc"
  echo "" >> ~/.zshrc
  echo "# Dotfiles (added by setup_new_mac.sh)" >> ~/.zshrc
  echo "$BASHRC_LINE" >> ~/.zshrc
  echo "Done."
fi
echo ""
echo "Setup complete. Restart your terminal or run: source ~/.zshrc"
