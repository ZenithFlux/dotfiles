hl.config({
    plugin = {
        hyprcapture = {
            default_mode = "fullscreen",
            filename_template = "Screenshot_%Y-%m-%d_%H-%M-%S.png",
        }
    }
})

-- Plugin Keybinds
hl.bind("PRINT", function() hl.plugin.hyprcapture.open("fullscreen") end)
hl.bind("SHIFT + PRINT", function() hl.plugin.hyprcapture.open("region") end)
