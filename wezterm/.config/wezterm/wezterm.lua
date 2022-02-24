local function merge(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end
    return t1
end

require("conf.event")

local config = {
    window_close_confirmation = "NeverPrompt",
    check_for_updates = false,
    automatically_reload_config = false,
    hide_tab_bar_if_only_one_tab = true,
    default_cursor_style = "BlinkingBar",
    window_padding = { top = 30, bottom = 30, left = 40, right = 40 },
    inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
}

local files = { "mapping", "font", "color" }
for _, f in ipairs(files) do
    config = merge(config, require("conf." .. f))
end

return config