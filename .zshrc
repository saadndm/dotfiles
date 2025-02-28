ZSH_THEME="agnoster"
ENABLE_CORRECTION="true"

# Env variables
export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:$HOME/.local/bin
export PATH=/usr/local/bin:$PATH
export EDITOR="nvim"

# Alias
alias lg="lazygit"

# Desktop specific
export PATH=$PATH:$HOME/Documents/Tools/platform-tools
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/winapps/bin
export LIBVIRT_DEFAULT_URI='qemu:///system'
export PYTORCH_ROCM_ARCH="gfx1031"
export HSA_OVERRIDE_GFX_VERSION=10.3.0
export HIP_VISIBLE_DEVICES=0

function WIN() {
    local title=$(sudo grep -i 'windows' /boot/grub2/grub.cfg | cut -d"'" -f2)
    if [ -n "$title" ]; then
        sudo grub2-reboot "$title"
        sudo reboot
    else
        echo "Windows entry not found in GRUB configuration."
    fi
}

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

# Zsh
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
plugins=(git bun zsh-autosuggestions nvm zsh-shift-select zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

eval "$(zoxide init zsh)"
