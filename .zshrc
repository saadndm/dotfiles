ZSH_THEME="agnoster"

# Env variables
export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=/usr/local/bin:$PATH
export EDITOR="nvim"

# Make ctrl stuff work
bindkey '^[[126;5u' backward-kill-word
bindkey '^?' backward-kill-word
bindkey '^H' backward-kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

# Zellij
if [[ -z "$ZELLIJ" ]] && [[ -z "$SSH_CONNECTION" ]] && [[ "$TERM" == "xterm-ghostty" ]]; then
    if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
        zellij attach -c
    else
        zellij -l welcome
    fi

    if [[ "$ZELLIJ_AUTO_EXIT" == "TRUE" ]]; then
        exit
    fi
fi

# Zsh
plugins=(git bun zsh-autosuggestions nvm zsh-shift-select fast-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

eval "$(zoxide init zsh)"

# Alias
alias lg="lazygit"
alias ls="eza --icons=auto --group-directories-first"
