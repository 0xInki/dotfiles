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

IS_LINUX=false
grep -qi microsoft /proc/version 2>/dev/null && IS_LINUX=true
[ "$(uname -s)" = "Linux" ] && IS_LINUX=true

if [ "$IS_LINUX" = true ]; then
  echo "Linux/WSL detected — installing dependencies..."

  sudo apt-get update -qq
  sudo apt-get install -y zsh curl git fzf tmux build-essential fd-find unzip nodejs npm

  # fd-find installs as "fdfind" on Ubuntu — create alias
  if ! command -v fd &>/dev/null && command -v fdfind &>/dev/null; then
    sudo ln -sf "$(which fdfind)" /usr/local/bin/fd
  fi

  # neovim
  if ! command -v nvim &>/dev/null; then
    echo "  installing neovim..."
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt-get update -qq
    sudo apt-get install -y neovim
  fi

  # win32yank (clipboard bridge for neovim in WSL)
  if ! command -v win32yank.exe &>/dev/null; then
    echo "  installing win32yank..."
    curl -Lo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/latest/download/win32yank-x64.zip
    unzip -o /tmp/win32yank.zip -d /tmp win32yank.exe
    sudo install /tmp/win32yank.exe /usr/local/bin/
    rm /tmp/win32yank.zip /tmp/win32yank.exe
  fi

  # lazygit
  if ! command -v lazygit &>/dev/null; then
    echo "  installing lazygit..."
    LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep tag_name | cut -d'"' -f4)
    curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION#v}_Linux_x86_64.tar.gz"
    tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
    sudo install /tmp/lazygit /usr/local/bin
    rm /tmp/lazygit.tar.gz /tmp/lazygit
  fi

  # thefuck
  if ! command -v thefuck &>/dev/null; then
    echo "  installing thefuck..."
    sudo apt-get install -y python3-pip
    pip3 install thefuck --user
  fi

  # jump
  if ! command -v jump &>/dev/null; then
    echo "  installing jump..."
    JUMP_VERSION=$(curl -s https://api.github.com/repos/gsamokovarov/jump/releases/latest | grep tag_name | cut -d'"' -f4)
    curl -Lo /tmp/jump "https://github.com/gsamokovarov/jump/releases/download/${JUMP_VERSION}/jump_${JUMP_VERSION#v}_linux_amd64"
    sudo install /tmp/jump /usr/local/bin/
    rm /tmp/jump
  fi

  # markdownlint (used by neovim lint.lua)
  if ! command -v markdownlint &>/dev/null; then
    echo "  installing markdownlint..."
    sudo npm install -g markdownlint-cli
  fi

  # oh-my-zsh
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "  installing oh-my-zsh..."
    RUNZSH=no CHSH=no sh -c \
      "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  # nvm
  if [ ! -d "$HOME/.nvm" ]; then
    echo "  installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  fi

  # set zsh as default shell
  if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
    echo "  zsh set as default shell (re-login to take effect)"
  fi
fi

echo "Installing dotfiles from $DOTFILES_DIR..."

backup_and_link "$DOTFILES_DIR/zsh/.zshrc"     "$HOME/.zshrc"
backup_and_link "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
if [ "$(uname -s)" = "Darwin" ]; then
  backup_and_link "$DOTFILES_DIR/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
else
  backup_and_link "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
fi
backup_and_link "$DOTFILES_DIR/nvim"            "$HOME/.config/nvim"

echo "Done."
