hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = -0.5, -- -1.0 - 1.0, 0 means no modification.
        accel_profile = "flat",

        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.1,
        },
    },
})

hl.device({
    name = "elan07fb:00-04f3:321a-touchpad";
    sensitivity = 0,
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "scroll_move"
})

hl.gesture({
    fingers = 4,
    direction = "horizontal",
    action = "workspace"
})
