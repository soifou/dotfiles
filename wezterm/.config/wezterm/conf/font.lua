local wezterm = require('wezterm')

-- See: https://github.com/wez/wezterm/blob/main/config/src/font.rs
-- Debug with wezterm ls-fonts --list-system
-- and wezterm ls-fonts --text "say something"
return {
    font_size = 12,
    -- line_height = 1.1,
    -- cell_width = 0.9, -- stretch the main font
    bold_brightens_ansi_colors = true,
    font = wezterm.font_with_fallback({
        -- FIXME: using directly the 'monospace' family results in a different way
        'Iosevka Custom',
        {
            family = 'Symbols Nerd Font Mono',
            scale = 0.8,
        },
    }),
    custom_block_glyphs = true, -- fix alignment of glyphs!
    warn_about_missing_glyphs = false,
    -- allow_square_glyphs_to_overflow_width = 'Never',
}
