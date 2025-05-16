# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Run on init

cd

# Auto-start tmux only if not already in a tmux session
if command -v tmux &> /dev/null && [[ -z "$TMUX" ]]; then
  tmux
fi

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
  copypath
)

source $ZSH/oh-my-zsh.sh

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
alias etmux="vim ~/dotfiles/.tmux.conf"
alias evim="vim ~/dotfiles/nvim/init.lua"

# open file in vim after fzf
# fvim() {
#   local target
#  target="$(fzf)" || return  # exit if cancelled
# 
#  if [ -z "$target" ]; then
#   return
#   elif [ -d "$target" ]; then
#     cd "$target" || echo "Failed to cd into $target"
#   elif [ -f "$target" ]; then
#     vim "$target"
#   else
#     echo "Selected item is neither a file nor a directory: $target"
#   fi
# }

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

PATH=$PATH:/Android/bin;export PATH;

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools


export PATH="/home/boehme/.nvm/versions/node/v10.1.0/bin:/home/boehme/bin:/home/boehme/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/lib/jvm/java-8-oracle/bin:/usr/lib/jvm/java-8-oracle/db/bin:/usr/lib/jvm/java-8-oracle/jre/bin:/Android/bin:/home/boehme/Android/Sdk/tools:/home/boehme/Android/Sdk/tools/bin:/home/boehme/Android/Sdk/platform-tools:/home/boehme/android-studio/bin:/home/boehme/.vimpkg/bin"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

#CUSTOM PROMPT
PS1='%F{white}[%F{202}%c%F{white}]%f %F{202}火%f '

git_status_prompt() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    local dirty=""
    local staged=""
    local ahead=""
    
    # Check uncommitted changes
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
      dirty="%F{white}*%f"
    fi
    
    # Check staged changes
    git diff --cached --quiet --ignore-submodules -- . || staged="%F{white}+%f"
    
    # Check if ahead of remote
    if [[ $(git rev-list --count @{upstream}..HEAD 2>/dev/null) -gt 0 ]]; then
      ahead="%F{white}↑%f"
    fi
    
    echo "%F{202}${branch}%f${dirty}${staged}${ahead}"
  else
    echo ""
  fi
}

RPROMPT='$(git_status_prompt)'

# CUSTOM GIT MESSAGES
source ~/dotfiles/git-messages.zsh

function git() {
  local exit_code

  if [[ $1 == "push" ]]; then
    command git "$@"
    exit_code=$?
    [[ $exit_code -eq 0 ]] && git_push_message || git_push_fail
    return $exit_code

  elif [[ $1 == "commit" ]]; then
    command git "$@"
    exit_code=$?
    [[ $exit_code -eq 0 ]] && git_commit_message || git_commit_fail
    return $exit_code

  elif [[ $1 == "pull" ]]; then
    command git "$@"
    exit_code=$?
    [[ $exit_code -eq 0 ]] && git_pull_message || git_pull_fail
    return $exit_code

  elif [[ $1 == "status" ]]; then
    git_status_art
    return $?

  else
    command git "$@"
  fi
}
