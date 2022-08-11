local function merge(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end
    return t1
end

require("conf.event")

local config = {
    adjust_window_size_when_changing_font_size = false, -- I'm using a tiling WM
    automatically_reload_config = false,
    check_for_updates = false,
    default_cursor_style = "SteadyBar",
    enable_kitty_keyboard = true,
    force_reverse_video_cursor = true,
    hide_tab_bar_if_only_one_tab = true,
    inactive_pane_hsb = { saturation = 0.9, brightness = 0.8 },
    term = "wezterm",
    window_close_confirmation = "NeverPrompt",
    window_padding = { top = 30, bottom = 30, left = 40, right = 40 },
}

for _, f in ipairs({ "mapping", "font", "color" }) do
    config = merge(config, require(("conf.%s"):format(f)))
end

return config
