# Najprej odstranite ali premaknite `neofetch`:
# NE uporabljajte neofetch tukaj, če želite instant prompt
# neofetch  # ODSTRANITE TO VRSTICO ALI JO KOMENTIRAJTE

# Nato uredite vašo .zshrc takole:
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Tukaj naj bodo samo tisti ukazi, ki NE PROIZVAJAJO IZPISOV
# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source ~/.zplug/init.zsh

# Make sure to use double quotes to prevent shell expansion
zplug "zsh-users/zsh-syntax-highlighting"
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/git-prompt", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "romkatv/powerlevel10k", as:theme, depth:1  # DODAJTE TO

# Tab autocomplete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# History
HISTSIZE=1000
SAVEHIST=1000
HISTFILE="$HOME/.local/share/zsh_history"

# ODSTRANITE STARO PROMPT KONFIGURACIJO, ker jo zdaj upravlja Powerlevel10k
# autoload -Uz add-zsh-hook vcs_info
# setopt prompt_subst
# add-zsh-hook precmd vcs_info
# 
# PROMPT='%F{blue}%n%F{default}@%F{blue}%m%f %F{blue}%~% %F{default}%b$(git_super_status) => '
# RPROMPT='%F{blue}%*%f'

# ODSTRANITE: source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# Powerlevel10k je zdaj skozi zplug

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Install packages that have not been installed yet
# PREMAKNITE ZPLUG CHECK NA KONEC
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

zplug load

# Če želite še vedno uporabljati neofetch, ga zaženite na koncu
# vendar to lahko še vedno povzroči opozorilo
# neofetch  # Če želite, odkomentirajte, vendar boste morda videli opozorilo

alias ssh='TERM=xterm-256color ssh'
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:~/.spicetify


source /usr/share/nvm/init-nvm.sh

export PATH=$PATH:/home/miha/.spicetify

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
(( ! ${+functions[p10k]} )) || p10k finalize
