# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Plugins
plugins=(
  git
  vi-mode
  npm
  jump
  tmux
)

DISABLE_BRACKETED_PASTE="true"
source $ZSH/oh-my-zsh.sh

# =============================================================================
# HISTORY
# =============================================================================
setopt HIST_IGNORE_DUPS    # don't record duplicate consecutive commands
setopt HIST_IGNORE_SPACE   # commands starting with a space are not saved
setopt SHARE_HISTORY       # share history across all open terminals in real time

# fzf shell integration
if [[ "$(uname -s)" == "Darwin" ]]; then
  [ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  [ -f /opt/homebrew/opt/fzf/shell/completion.zsh ] && source /opt/homebrew/opt/fzf/shell/completion.zsh
else
  [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
  [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
fi

# =============================================================================
# ALIASES
# =============================================================================
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias qq='exit'
alias ezsh="vim ~/dotfiles/zsh/.zshrc"
alias szsh="source ~/.zshrc"
alias etmux="vim ~/dotfiles/tmux/.tmux.conf"
alias stmux="source ~/.tmux.conf"
alias evim="vim ~/dotfiles/nvim/init.lua"
alias j='jump'
alias lg='lazygit'

# =============================================================================
# TMUX ALIASES E FUNÇÕES
# =============================================================================

# Aliases básicos do tmux
alias t='tmux'
alias ta='tmux attach'
alias tls='tmux list-sessions'
alias tks='tmux kill-session'
alias tksa='tmux kill-server'

# Função para criar/attach sessão
tm() {
    if [ -z "$1" ]; then
        echo "Uso: tm <nome-da-sessao>"
        echo "Exemplo: tm dev"
        return 1
    fi
    
    if tmux has-session -t "$1" 2>/dev/null; then
        echo "Anexando à sessão existente: $1"
        tmux attach-session -t "$1"
    else
        echo "Criando nova sessão: $1"
        tmux new-session -s "$1"
    fi
}

# Função para desenvolvimento (cria layout com múltiplos painéis)
tmdev() {
    local session_name=${1:-dev}
    
    if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux attach-session -t "$session_name"
    else
        tmux new-session -d -s "$session_name"
        tmux split-window -h -t "$session_name"
        tmux split-window -v -t "$session_name:0.1"
        tmux select-pane -t "$session_name:0.0"
        tmux attach-session -t "$session_name"
    fi
}

# Função para listar e escolher sessão
tms() {
    local sessions=$(tmux list-sessions -F "#{session_name}" 2>/dev/null)
    
    if [ -z "$sessions" ]; then
        echo "Nenhuma sessão tmux encontrada."
        return 1
    fi
    
    echo "Sessões disponíveis:"
    echo "$sessions" | nl
    echo -n "Escolha uma sessão (número): "
    read choice
    
    local session_name=$(echo "$sessions" | sed -n "${choice}p")
    if [ -n "$session_name" ]; then
        tmux attach-session -t "$session_name"
    else
        echo "Escolha inválida."
    fi
}


dev() {
  echo "Running: npm run dev"
  output=$(npm run dev 2>&1)
  echo "$output"

  if echo "$output" | grep -i -q 'missing script: ["'\'']\?dev["'\'']\?'; then
    echo "Script 'dev' not found. Falling back to: npm run start-dev"
    npm run start-dev
  fi
}

fuck() { eval $(thefuck $(fc -ln -1) 2>/dev/null); }


export NVM_DIR="$HOME/.nvm"
if [[ "$(uname -s)" == "Darwin" ]]; then
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
else
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi



# CUSTOM GIT MESSAGES
source ~/dotfiles/git-messages.zsh

#CUSTOM PROMPT
PS1='%F{white}[%F{202}%c%F{white}]%f %F{202}火%f '

RPROMPT='$(git_status_prompt)'
export RANGER_FURY_LOCATION="$HOME/.fury"
export RANGER_FURY_VENV_LOCATION="$HOME/.fury/fury_venv"
export FURY_BIN_LOCATION="$HOME/.fury/fury_venv/bin"
export PATH="$PATH:$FURY_BIN_LOCATION"
export PATH="$HOME/.local/bin:$PATH"

# Nordic Doctor configuration
export NORDIC_DOCTOR_DIR="$HOME/.nordic-doctor"
export PATH="$NORDIC_DOCTOR_DIR/bin:$PATH"

# Homebrew (macOS only)
[[ "$(uname -s)" == "Darwin" ]] && export PATH="/opt/homebrew/bin:$PATH"

export EDITOR="nvim"
export VISUAL="nvim"
