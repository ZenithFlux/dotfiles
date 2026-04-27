# dotfiles

Setup steps:

1. Following files should be copied to the home directory:
    - **my.bashrc**:  `source my.bashrc` in `.bashrc`.
    - **my.inputrc**: `$include my.inputrc` in `.inputrc`.
2. Put contents of the `config` directory in `~/.config` directory of the system.
    - Install tpm: `git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm`
    - Install `fzf` to use the quick directory search in `config/tmux/new_session.sh`. (Optional)
3. Put `clear_trash` in `/etc/cron.daily` directory to automatically delete files older than 30 days from the trash daily.
