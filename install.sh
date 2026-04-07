#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

backup_and_link() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"

  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "  backing up $dest -> $dest.bak"
    mv "$dest" "$dest.bak"
  fi

  ln -sf "$src" "$dest"
  echo "  linked $dest -> $src"
}

echo "Installing dotfiles from $DOTFILES_DIR..."

backup_and_link "$DOTFILES_DIR/zsh/.zshrc"     "$HOME/.zshrc"
backup_and_link "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
backup_and_link "$DOTFILES_DIR/ghostty/config"  "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
backup_and_link "$DOTFILES_DIR/nvim"            "$HOME/.config/nvim"

echo "Done."
