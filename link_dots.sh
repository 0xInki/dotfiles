#!/bin/bash

# Path to your dotfiles folder (adjust as needed)
DOTFILES="$HOME/dotfiles"

# List of configs and their targets
declare -A FILES=(
  [".tmux.conf"]="$DOTFILES/.tmux.conf"
  [".zshrc"]="$DOTFILES/.zshrc"
  [".config/nvim"]="$DOTFILES/nvim"
)

echo "Setting up symlinks for dotfiles..."

for TARGET in "${!FILES[@]}"; do
  DEST="$HOME/$TARGET"
  SRC="${FILES[$TARGET]}"

  # Remove existing file or directory
  if [ -e "$DEST" ] || [ -L "$DEST" ]; then
    echo "Removing existing $DEST"
    rm -rf "$DEST"
  fi

  # Ensure parent directory exists
  mkdir -p "$(dirname "$DEST")"

  # Create symlink
  ln -s "$SRC" "$DEST"
  echo "Linked $DEST → $SRC"
done

echo "Dotfiles setup complete.":
