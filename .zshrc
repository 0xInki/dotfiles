# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Run on init

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  vi-mode
  npm
  jump
  tmux
)

source $ZSH/oh-my-zsh.sh

# Disable bracketed-paste-magic loaded by oh-my-zsh/lib/misc.zsh
zle -D bracketed-paste 2>/dev/null
unfunction bracketed-paste-magic 2>/dev/null


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vi='nvim'
alias vim='nvim'
alias qq='exit'
alias c='copypath'
alias ezsh="vim ~/dotfiles/.zshrc"
alias szsh="source ~/.zshrc"
alias etmux="vim ~/.tmux.conf"
alias stmux="source ~/.tmux.conf"
alias evim="vim ~/dotfiles/nvim/init.lua"
alias svim="source ~/nvim/init.lua"
alias j='jump'

fvim() {
  local target action

  # Run fzf with a custom key binding Ctrl-d to select a directory
  # Enter (default) selects file, Ctrl-d selects directory
  target=$(fzf --expect=ctrl-d) || return

  # The first line of output is the key pressed
  action=$(head -1 <<< "$target")
  # The second line is the selected file/folder path
  target=$(tail -1 <<< "$target")

  # If no selection, exit
  [ -z "$target" ] && return

  if [ "$action" = "ctrl-d" ]; then
    # If Ctrl-d pressed, cd into folder if it is directory
    if [ -d "$target" ]; then
      cd "$target" || echo "Failed to cd into $target"
    else
      echo "'$target' is not a directory"
    fi
  else
    # Default Enter pressed: open file if it exists
    if [ -f "$target" ]; then
      vim "$target"
    else
      echo "'$target' is not a file"
    fi
  fi
}

eval $(thefuck --alias)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="/opt/homebrew/bin:$PATH"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# CUSTOM GIT MESSAGES
source ~/dotfiles/git-messages.zsh

#CUSTOM PROMPT
PS1='%F{white}[%F{202}%c%F{white}]%f %F{202}火%f '

RPROMPT='$(git_status_prompt)'
