-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name = "float-rename-window",
    match = {
        initial_class = "thunar",
        initial_title = 'Rename ".*"',
    },
    float = true,
})

hl.window_rule({
    name = "float-file-operation-progress",
    match = {
        initial_class = "thunar",
        initial_title = 'File Operation Progress',
    },
    float = true,
})

hl.window_rule({
    name = "float-libre-import",
    match = {
        initial_class = "soffice",
        initial_title = '.* Import .*',
    },
    float = true,
})

hl.window_rule({
    name = "position-screenshare-bar",
    match = {
        initial_title = '.* is sharing your screen.',
    },
    move = {"monitor_w * 0.5 - window_w * 0.5", "monitor_h * 0.95 - window_h"},
    pin = true,
})

hl.window_rule({
    name = "float-hyprland-share-picker",
    match = {
        initial_class = "hyprland-share-picker",
    },
    float = true,
})
