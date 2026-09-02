-- The log file will be at $XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/hyprland.log
-- Lua output will be prefixed with "[Lua]"
-- hl.config({ debug = { disable_logs = false } })

local vars = require("hyprland_configs.vars")

--- Environment Variables ---

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "hyprland")
hl.env("DESKTOP_SESSION", "hyprland")
hl.env("LIBSEAT_BACKEND", "logind")

-- Forcibly restrict Hyprland to one gpu
-- hl.env("AQ_DRM_DEVICES", "/dev/dri/igpu")

-- Use kvantum + qt6ct-kde to configure themes for QT applications
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

hl.env("GDK_SCALE", tostring(vars.eDP1_display_scale))
hl.env("HYPRCURSOR_SIZE", tostring(math.floor(16 * vars.eDP1_display_scale)))
hl.env("XCURSOR_SIZE", tostring(math.floor(16 * vars.eDP1_display_scale)))

hl.env("HYPRCURSOR_THEME", vars.cursor_theme)
hl.env("XCURSOR_THEME", vars.cursor_theme)

-- To communicate with ssh-agent.service
hl.env("SSH_AUTH_SOCK", os.getenv("XDG_RUNTIME_DIR") .. "/ssh-agent.socket")

hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

-----------------------------

require("hyprland_configs.core")
require("hyprland_configs.inputs")
require("hyprland_configs.plugins")
require("hyprland_configs.appearance")
require("hyprland_configs.keybinds")
require("hyprland_configs.rules")
