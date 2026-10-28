#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
TERM="screen-256color"

export RDP_CONNECT_CLIENT="sdl"
export DMENU_BLUETOOTH_LAUNCHER="rofi -dmenu"
export QT_QPA_PLATFORMTHEME="qt6ct"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Automatically load all private SSH keys into the agent on login
if [ -d "$HOME/.ssh" ]; then
    # Find files that look like private keys (ignoring public .pub files, configs, and authorized_keys)
    for key in "$HOME/.ssh"/id_*; do
        # Ensure the file exists and is not a public key
        if [ -f "$key" ] && [[ "$key" != *.pub ]]; then
            ssh-add "$key" 2>/dev/null
        fi
    done
fi

eval "$(starship init bash)"

if [[ -n "\$PS1" ]] && [[ -z "\$TMUX" ]] && [[ -n "\$SSH_CONNECTION" ]]; then
  tmux attach-session -t remote || tmux new-session -s remote
fi

fastfetch
