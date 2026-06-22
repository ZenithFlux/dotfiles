#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if command -v fzf 2>&1 > /dev/null; then
    eval "$(fzf --bash)"
fi

tmux_script="$HOME/.config/tmux/new_session.sh"
if [ -z "$TMUX" ] && [ -f "$tmux_script" ]; then
    source "$tmux_script"
fi
unset tmux_script

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Bash settings
set -o vi
shopt -s histappend
HISTCONTROL=erasedups
PS1='\[\e[38;2;87;204;247m\e[1m\]\u\[\e[22m\] \[\e[38;2;150;150;150m\]${PWD#"${PWD%/*/*}/"} \[\e[38;2;111;214;100m\]❯\[\e[0m\] '

[ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh

function update {
    if [ "$1" = "mirrorlist" ]; then
        echo "Starting 'reflector.service' to update /etc/pacman.d/mirrorlist ..."
        echo -e "To stop it, run \`sudo systemctl stop reflector.service\`.\n"
        sudo systemctl start --no-block reflector.service && journalctl -fu reflector.service
    elif [ "$1" = "pkgs" ]; then
        paru -Syu
    else
        echo "ERROR: Invalid or no argument!!"
    fi
}

function ex { thunar ${1-.} > /dev/null 2>&1 & disown; }

[ -f ~/private.bashrc ] && source ~/private.bashrc

# Initialize environment for projects
initfile=.bashinit
[ -f $initfile ] && . $initfile
