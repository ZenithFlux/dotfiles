# dotfiles

Setup steps:

1. Following files should be copied to the home directory:
    - **my.bashrc**:  `source my.bashrc` in `.bashrc`.
    - **my.inputrc**: `$include my.inputrc` in `.inputrc`.
    - **conda.bashrc**
2. Put contents of the `config` directory in `~/.config` directory of the system.
3. Put `clear_trash` in `/etc/cron.daily` directory to automatically delete files older than 30 days from the trash daily.
