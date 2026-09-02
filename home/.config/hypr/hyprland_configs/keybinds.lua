local vars = require("hyprland_configs.vars")

local mainMod = "ALT"

hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/reload_configs.sh"))

hl.bind(mainMod .. " + O", function()
    local active_mon = hl.get_active_monitor()
    if active_mon ~= nil and active_mon.name ~= "eDP-1" and active_mon.name ~= "HDMI-A-1" then
        return
    end

    local disable_hdmi = active_mon == nil or active_mon.name == "HDMI-A-1"

    hl.monitor({
        output = "eDP-1",
        disabled = not disable_hdmi,
        mode = "preferred",
        position = "0x0",
        scale = vars.eDP1_display_scale,
        icc = vars.eDP1_icc_path(),
    })

    hl.monitor({
        output = "HDMI-A-1",
        disabled = disable_hdmi,
        mode = "preferred",
        position = "0x0",
        scale = vars.HDMI_display_scale,
    })
end)

hl.bind(mainMod .. " + END", hl.dsp.exec_cmd("poweroff"))
hl.bind(mainMod .. " + KP_END", hl.dsp.exec_cmd("poweroff"))
hl.bind(mainMod .. " + SHIFT + END", hl.dsp.exec_cmd("reboot"))
hl.bind(mainMod .. " + SHIFT + KP_END", hl.dsp.exec_cmd("reboot"))
hl.bind(mainMod .. " + DELETE", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + HOME", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(mainMod .. " + KP_HOME", hl.dsp.exec_cmd("loginctl lock-session"))

hl.bind(mainMod .. " + V", hl.dsp.global("com.github.hluk.copyq:ALT+V||Show/hide main window"))

hl.bind(mainMod .. " + SHIFT + T", function()
    hl.dispatch(hl.dsp.focus({ workspace = 1 }))
    hl.dispatch(hl.dsp.exec_cmd(vars.terminal))
end)
hl.bind(mainMod .. " + SHIFT + B", function()
    hl.dispatch(hl.dsp.focus({ workspace = 2 }))
    hl.dispatch(hl.dsp.exec_cmd(vars.browser))
end)
hl.bind(mainMod .. " + SHIFT + F", function()
    hl.dispatch(hl.dsp.focus({ workspace = 3 }))
    hl.dispatch(hl.dsp.exec_cmd(vars.fileManager))
end)
hl.bind(mainMod .. " + M", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(vars.app_launcher))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(vars.symbol_picker))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/dunst/scripts/volume.sh up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/dunst/scripts/volume.sh down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/dunst/scripts/volume.sh mute"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/dunst/scripts/mic.sh mute"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/dunst/scripts/brightness.sh up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/dunst/scripts/brightness.sh down"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.bind("switch:off:Lid Switch", hl.dsp.dpms({ action = "enable" }), { locked = true })
