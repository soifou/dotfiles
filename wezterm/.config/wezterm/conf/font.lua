local wezterm = require("wezterm")

local function font_with_fallback(name, params)
    local names = { name, "Symbols Nerd Font", "Noto Color Emoji", "icomoon\\-feather" }
    return wezterm.font_with_fallback(names, params)
end

return {
    font_size = 12.0,
    line_height = 1.0,
    bold_brightens_ansi_colors = false,
    font = font_with_fallback("Iosevka Custom", { weight = "Regular" }),
    warn_about_missing_glyphs = false,
    custom_block_glyphs = false,
}
