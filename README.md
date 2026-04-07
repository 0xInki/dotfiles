# dotfiles

My personal development environment for macOS.

## Prerequisites

Install the following tools before running the setup script.

### 1. Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After installing, follow the instructions to add Homebrew to your PATH.

### 2. Core tools

```bash
brew install tmux neovim fzf thefuck jump git
```

### 3. Ghostty

Download and install from https://ghostty.org

### 4. Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 5. NVM + Node

```bash
brew install nvm
```

Then add the following to your shell (temporarily, before running the install script) to activate nvm:

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
```

Then install Node:

```bash
nvm install --lts
```

## Installation

Copy the `dotfiles/` folder to your home directory, then run:

```bash
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

The script will create symlinks from the expected config locations to the files in this repo. If a config file already exists, it will be backed up with a `.bak` extension before being replaced.

## What gets linked

| Tool | Config location |
|------|----------------|
| zsh | `~/.zshrc` |
| tmux | `~/.tmux.conf` |
| ghostty | `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty` |
| nvim | `~/.config/nvim/` |

## Post-install

### tmux plugins

TMux Plugin Manager (TPM) is installed automatically the first time you start tmux. After that, install all plugins by pressing:

```
Ctrl+a  I
```

### Neovim plugins

Open nvim and wait for lazy.nvim to install all plugins automatically:

```bash
nvim
```

### Git

Configure your identity:

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```
