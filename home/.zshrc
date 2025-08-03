ZSH_THEME="agnoster"

# Env variables
export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=/usr/local/bin:$PATH
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export XDG_CONFIG_HOME="$HOME/.config"

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

# Zsh
plugins=(git bun zsh-autosuggestions zsh-shift-select fast-syntax-highlighting zsh-fzf-history-search)
source $ZSH/oh-my-zsh.sh

# Fzf
source ~/.config/fzf/catppuccin-fzf-mocha.sh
eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# zoxide
eval "$(zoxide init zsh)"
alias cd="zd"
zd() {
  if [ $# -eq 0 ]; then
    builtin cd ~ && return
  elif [ -d "$1" ]; then
    builtin cd "$1"
  else
    z "$@" && printf " \U000F17A9 " && pwd || echo "Error: Directory not found"
  fi
}

# Mise
eval "$(/usr/bin/mise activate zsh)"

# Alias
alias lg="lazygit"
alias ls="eza --color=always --long --no-filesize --icons=always --no-time --no-user --no-permissions -G"
alias lsa="eza --color=always --long --no-filesize --icons=always --no-time --no-user --no-permissions -a -G"
alias yay="paru"
alias n="nvim"
alias yayf="paru -Slq | fzf --multi --preview 'paru -Sii {1}' --preview-window=down:75% | xargs -ro paru -S"
alias cat="bat"

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

function zle-copy-region-to-clipboard() {
  emulate -L zsh
  (( REGION_ACTIVE )) || { zle beep; return 0 }

  local s=$MARK e=$CURSOR

  if (( s > e )); then
    (( s = CURSOR, e = MARK ))
  fi

  local t=${BUFFER:$s:$((e - s))}

  if   command -v wl-copy &>/dev/null; then
    print -rn -- "$t" | wl-copy
  elif command -v xclip   &>/dev/null; then
    print -rn -- "$t" | xclip -selection clipboard
  elif [[ "$OSTYPE" == darwin* ]]; then
    print -rn -- "$t" | pbcopy
  else
    print -u2 "✖ no wl-copy/xclip/pbcopy found"
    return 1
  fi

  zle deactivate-region
  zle -R
}

zle -N zle-copy-region-to-clipboard
bindkey -M shift-select '^[[99;6u' zle-copy-region-to-clipboard
