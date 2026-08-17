local vars = require("hyprland_configs.vars")

------------------
---- MONITORS ----
------------------

---@type string|nil
local icc_path = "/usr/share/color/icc/main.icc"

---@cast icc_path string
local f = io.open(icc_path, "rb")
if f then
    f:close()
else
    icc_path = nil
end

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output = "eDP-1",
    mode = "1920x1080@144",
    position = "0x0",
    scale = vars.display_scale,
    icc = icc_path,
})

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function ()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user start hyprland-session.target")
    hl.exec_cmd("hyprpm reload")
    hl.exec_cmd("dunst")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("/usr/bin/ssh-agent -a " .. os.getenv("SSH_AUTH_SOCK"))
end)

hl.on("hyprland.shutdown", function()
    os.execute("killall -e ssh-agent")
    os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
    -- uses a blocking exec function and sleeps a bit to give things time to close
    -- you might also want to kill troublesome/crashing non-systemd background services here:
    -- os.execute("pkill wallpaperthing; systemctl --user stop hyprland-session.target && sleep 0.1")
end)

hl.config({
    general = {
        resize_on_border = false,
        layout = "scrolling",
    },
    cursor = {
        hide_on_key_press = true,
    },
    scrolling = {
        column_width = 1,
        fullscreen_on_one_column = true,
    },
    xwayland = {
        force_zero_scaling = true
    },
    dwindle = {
        preserve_split = true, -- You probably want this
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")
