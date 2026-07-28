hl.config({
    plugin = {
        hyprcapture = {
            default_mode = "fullscreen",
            filename_template = "Screenshot_%Y-%m-%d_%H-%M-%S.png",
        }
    }
})

-- Plugin Keybinds
hl.bind("PRINT", hl.plugin.hyprcapture.open)
