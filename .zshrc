# ─────────────────────────────────────────────
# Powerlevel10k instant prompt
# ─────────────────────────────────────────────

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ─────────────────────────────────────────────
# Environment
# ─────────────────────────────────────────────

export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/.spicetify"
export NVM_DIR="$HOME/.nvm"

alias ssh='TERM=xterm-256color ssh'


# ─────────────────────────────────────────────
# Powerlevel10k
# ─────────────────────────────────────────────

# Load directly from zplug's installed copy.
# This avoids zplug processing all plugins on every startup.

if [[ -r "$HOME/.zplug/repos/romkatv/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
    source "$HOME/.zplug/repos/romkatv/powerlevel10k/powerlevel10k.zsh-theme"
fi


# ─────────────────────────────────────────────
# Plugins
# ─────────────────────────────────────────────

# zsh-autosuggestions
if [[ -r "$HOME/.zplug/repos/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "$HOME/.zplug/repos/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# zsh-syntax-highlighting
if [[ -r "$HOME/.zplug/repos/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$HOME/.zplug/repos/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# zsh-history-substring-search
if [[ -r "$HOME/.zplug/repos/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh" ]]; then
    source "$HOME/.zplug/repos/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh"
fi


# ─────────────────────────────────────────────
# Completion
# ─────────────────────────────────────────────

autoload -Uz compinit
zmodload zsh/complist

zstyle ':completion:*' menu select

# Cached completion dump
compinit -C


# ─────────────────────────────────────────────
# History
# ─────────────────────────────────────────────

HISTSIZE=1000
SAVEHIST=1000
HISTFILE="$HOME/.local/share/zsh_history"


# ─────────────────────────────────────────────
# Powerlevel10k config
# ─────────────────────────────────────────────

[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"


# ─────────────────────────────────────────────
# Lazy NVM
# ─────────────────────────────────────────────

_nvm_lazy_load() {
    unfunction nvm node npm npx 2>/dev/null

    if [[ -s "$NVM_DIR/nvm.sh" ]]; then
        source "$NVM_DIR/nvm.sh"
    fi

    if [[ -s "$NVM_DIR/bash_completion" ]]; then
        source "$NVM_DIR/bash_completion"
    fi
}

nvm() {
    _nvm_lazy_load
    nvm "$@"
}

node() {
    _nvm_lazy_load
    command node "$@"
}

npm() {
    _nvm_lazy_load
    command npm "$@"
}

npx() {
    _nvm_lazy_load
    command npx "$@"
}
