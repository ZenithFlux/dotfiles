#!/usr/bin/env bash

PS1='\[\e[38;2;87;204;247m\e[1m\]\u\[\e[22m\] \[\e[38;2;150;150;150m\]${PWD#"${PWD%/*/*}/"} \[\e[38;2;111;214;100m\]❯\[\e[0m\] '
set -o vi

alias o="xdg-open"
alias python='python3'
alias anaconda='source ~/conda.bashrc'
alias mypackages="comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)"
alias sshpass='eval `ssh-agent` && ssh-add'
function ex { nemo ${1-.} > /dev/null 2>&1 & disown; }

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ -z $TMUX ]; then
    source ~/.config/tmux/new_session.sh
fi

# Initialize environment and stuff for projects
initfile=.bashinit
[ -f $initfile ] && . $initfile
