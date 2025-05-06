Following additional packages were installed after i3 and are used in the config:
- picom
- maim
- feh
- brightnessctl

Problems I faced and how I solved them:
- To change the Caps Lock behavior: Add XKBOPTIONS to `/etc/default/keyboard`.
- Everything too scaled up, including windows and text: Tune `Xft.dpi` setting in `~/.Xresources`.
- Theme not loaded: For gtk3, change `~/.config/gtk-3.0/settings.ini`.
- Black corners around windows due to rounded corner theme: Use the picom config included in this repo.
- Keymaps for screen brightness not working:
    1. Update the `/usr/lib/udev/rules.d/90-brightnessctl.rules` to its latest version on github.
    2. Add yourself to the 'video' and 'input' group in linux.
- SSH client repeatedly asking for ssh key:
    1. In `~/.ssh/config`, add the line `AddKeysToAgent yes`.
    2. Add a custom script to `/etc/X11/Xsession.d/` which executes the following:  
        ```sh
        killall -e ssh-agent
        eval $(ssh-agent) > /dev/null
        ```  
        See `man xsession` for info on custom scripts.
