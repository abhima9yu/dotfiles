# Resolve dotfiles root (directory containing this file)
if [ -n "${BASH_SOURCE[0]}" ]; then
  export DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
  export DOTFILES_ROOT="${DOTFILES_ROOT:-$HOME/dotfiles}"
fi
. "$DOTFILES_ROOT/dotfiles/bash/env"
. "$DOTFILES_ROOT/dotfiles/bash/config"
. "$DOTFILES_ROOT/dotfiles/bash/load_aliases"
