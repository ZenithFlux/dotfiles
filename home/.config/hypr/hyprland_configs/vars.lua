return {
    eDP1 = {
        display_scale = 1.2,
        vrr = 2,
        icc = function()
            ---@type string|nil
            local icc_path = "/usr/share/color/icc/main.icc"

            ---@cast icc_path string
            local f = io.open(icc_path, "rb")
            if f then
                f:close()
            else
                icc_path = nil
            end

            return icc_path
        end,
    },
    hdmi = {
        display_scale = 2,
        vrr = 2,
    },

    cursor_theme = "Bibata-Modern-Classic",

    terminal    = "kitty",
    browser     = "brave",
    fileManager = "thunar",
    app_launcher = "rofi -modes drun -show",
    symbol_picker = "rofi -modes rofimoji:rofimoji -show",
}
