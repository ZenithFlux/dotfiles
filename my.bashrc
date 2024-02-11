#!/usr/bin/bash

alias python='python3'
alias anaconda='source ~/conda.bashrc'
alias mypackages="comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)"
alias runssh='eval `ssh-agent` && ssh-add'
alias ex='nemo . > /dev/null 2>&1 & disown'

# Initialize environment and stuff for projects
initfile=.bashinit
cd `printf "$(pwd)\n$(find ~/personal ~/work ~/other -maxdepth 1 -type d,l)" | fzf` && [ -f $initfile ] && . $initfile
