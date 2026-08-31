# dotfiles

Configs and other files of my **Arch Linux** system.

Run `./check_sync.sh` to check if the repo files are synced with the system.

## Notes

> [!NOTE]  
> This section assumes that the files in this repo are synced with the system.

- **Reflector**: Enable the weekly timer with `sudo systemctl enable --now reflector.timer`. Also, reflector can't read the config file if its a symlink.

- **keyd**: Enable keyd with `sudo systemctl enable --now keyd`.

- **udev Rules**: Edit the device addresses in the gpu udev rules based on the output from `lspci -d ::03xx`. Using symlinks for the *.rules can sometimes cause Hyprland to crash on autologin, so avoid it.

- **Hyprland**
    - Requires: `dunst pipewire wireplumber xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xdg-desktop-portal-gnome hyprpolkitagent qt5-wayland qt6-wayland xorg-xhost`
    - Apps used in config: `hyprpaper hypridle hyprlock kitty thunar waybar rofi rofimoji brave copyq`
    - Plugins used: [HyprCapture](https://github.com/gfhdhytghd/HyprCapture)
    - Cursor Theme: [Bibata-Modern-Classic](https://github.com/ful1e5/Bibata_Cursor)
    - You may want to change monitor name in the `hypr/` configs.

- **Fonts**: The following fonts are a must install:
    - **A text font (like `noto-fonts noto-fonts-cjk`)**: Required to draw GUI windows and display text.
    - **A nerd font**: Required to display special icons, glyphs, and symbols. Install `ttf-jetbrains-mono-nerd` since it is being used in several configs.
    - **An emoji font (like `noto-fonts-emoji`)**: Required to display standard emojis.

- **greetd-tuigreet**: After installation, `sudo systemctl enable greetd.service`.

- **NetworkManager**: Install `network-manager-applet` to get a tray icon and a GUI to manage networks.

- **Audio**: Install `pipewire-pulse`.

- **Bluetooth**: Install `bluez bluez-utils blueman` and `sudo systemctl enable --now bluetooth.service`.

- **tmux**: Install `tpm` by following [these instructions](https://github.com/tmux-plugins/tpm#installation) and then install the plugins with `<prefix> + I`.

- **CopyQ**: All global shortcuts must be added both in the app's preferences and in the Hyprland config. `ALT + V` is already added in the Hyprland config.

- **Thunar**: Install the plugins and addons mentioned [here](https://wiki.archlinux.org/title/Thunar). If thunar fails to find the terminal, run `sudo ln -s /usr/bin/<your-terminal> /usr/bin/xterm`.

- **Timeshift**: After setting it up, enable cronie using `sudo systemctl enable --now cronie.service` for scheduled snapshots to work.

- **TLP**: `/etc/tlp.conf` is added only for backup and reference purposes. TLP should be configured specifically for each system.

- **QT+KDE themes**: Use `qt6ct-kde` and `kvantum` together to set themes for QT6 and KDE apps. Also install `qt5ct` and `kvantum-qt5` for QT5 apps.

- **GTK themes**: Use `nwg-look` to set themes for GTK apps.

- **Secure Boot**:
    1. Follow [these instructions](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot#shim_with_key) to generate an MOK pair along with `MOK.cer`. All MOK.* files should be kept in `/etc/secure-boot/`.
    3. Configure the variables in `shim-setup.sh` and `grub-mkstandalone-sign.sh` in `/usr/local/bin/`.
    4. Install `sbsigntools` and `shim-signed` and then run the following:
        ``` sh
        sudo grub-mkstandalone-sign.sh  # To generate a signed grub EFI (grubx64.efi)
        sudo mkinitcpio -P              # To sign the kernel
        ```
    5. After rebooting with secure boot enabled, enroll the `MOK.cer` placed along with the signed grub EFI.


<!-- - **Dolphin** -->
<!--     - For it to be able to detect apps, run `sudo ln -s /etc/xdg/menus/plasma-applications.menu /etc/xdg/menus/applications.menu` after `xdg-desktop-portal-kde` is installed. -->
<!--     - Edit `~/.config/kdeglobals` to modify KDE system settings which the application relies on (like `TerminalApplication`).  -->
<!--     - Install `ark` to add support for compressed files and `kio-admin` to get "Open as administrator" context option on folders. -->
