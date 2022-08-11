local wezterm = require("wezterm")

return {
    font_size = 12.0,
    line_height = 1.0,
    bold_brightens_ansi_colors = false,
    font = wezterm.font_with_fallback({
        "Iosevka Custom",
        {
            family = "Symbols Nerd Font",
            -- scale = 1.1, -- increase glyph size
        },
    }),
    warn_about_missing_glyphs = false,
    custom_block_glyphs = false,
}
