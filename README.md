# dotfiles

Configs and other files of my **Arch Linux** system.

Run `./check_sync.sh` to verify that the repo files are synced up with the system.

## Notes

- **Reflector**: Enable the weekly timer with `sudo systemctl enable --now reflector.timer`. Also, reflector can't read the config file if its a symlink.

- **keyd**: Enable keyd with `sudo systemctl enable --now keyd`.

- **udev Rules**: Edit the device addresses in the gpu udev rules based on the output from `lspci -d ::03xx`. Using symlinks for the *.rules can sometimes cause Hyprland to crash on autologin, so avoid it.

- **Hyprland**
    - Requires: `dunst pipewire wireplumber xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xdg-desktop-portal-gnome hyprpolkitagent qt5-wayland qt6-wayland xorg-xhost`
    - Apps used in config: `alacritty thunar waybar rofi rofimoji hyprpaper brave copyq`
    - Plugins used: [HyprCapture](https://github.com/gfhdhytghd/HyprCapture)
    - Cursor Theme: [Bibata-Modern-Classic](https://github.com/ful1e5/Bibata_Cursor)

- **Fonts**: The following fonts are a must install:
    - **A text font (like `noto-fonts noto-fonts-cjk`)**: Required to draw GUI windows and display text.
    - **A nerd font (like `ttf-jetbrains-mono-nerd`)**: Required to display special icons, glyphs, and symbols.
    - **An emoji font (like `noto-fonts-emoji`)**: Required to display standard emojis.

- **greetd-tuigreet**: After installation, `sudo systemctl enable greetd.service`.

- **NetworkManager**: Install `network-manager-applet` to get a tray icon and a GUI to manage networks.

- **Audio**: Install `pipewire-pulse`.

- **Bluetooth**: Install `bluez bluez-utils blueman` and `sudo systemctl enable --now bluetooth.service`.

- **tmux**: Install `tpm` by following [these instructions](https://github.com/tmux-plugins/tpm#installation) and then install the plugins with `<prefix> + I`.

- **CopyQ**: All global shortcuts must be added both in the app's preferences and in the Hyprland config. `ALT + V` is already added in the Hyprland config.

- **Thunar**: Install the plugins and addons mentioned [here](https://wiki.archlinux.org/title/Thunar).

- **Timeshift**: After setting it up, enable cronie using `sudo systemctl enable --now cronie.service` for scheduled snapshots to work.

- **TLP**: `/etc/tlp.conf` is added only for backup and reference purposes. TLP should be configured specifically for each system.

- **QT+KDE themes**: Use `qt6ct-kde` and `kvantum` together to set themes for QT6 and KDE apps. Also install `qt5ct` and `kvantum-qt5` for QT5 apps.

- **GTK themes**: Use `nwg-look` to set themes for GTK apps.


<!-- - **Dolphin** -->
<!--     - For it to be able to detect apps, run `sudo ln -s /etc/xdg/menus/plasma-applications.menu /etc/xdg/menus/applications.menu` after `xdg-desktop-portal-kde` is installed. -->
<!--     - Edit `~/.config/kdeglobals` to modify KDE system settings which the application relies on (like `TerminalApplication`).  -->
<!--     - Install `ark` to add support for compressed files and `kio-admin` to get "Open as administrator" context option on folders. -->
