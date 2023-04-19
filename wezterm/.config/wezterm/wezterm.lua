local wezterm = require('wezterm')
local events = require('events')
local utils = require('utils')

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
    config:set_strict_mode(true)
end

events.attach()

config = utils.merge(config, {
    -- https://wezfurlong.org/wezterm/config/lua/config/index.html
    automatically_reload_config = false,
    check_for_updates = false,
    default_cursor_style = 'SteadyBar',
    enable_kitty_keyboard = true,
    force_reverse_video_cursor = true,
    hide_tab_bar_if_only_one_tab = true,
    inactive_pane_hsb = { saturation = 0.9, brightness = 0.8 },
    term = 'wezterm',
    use_fancy_tab_bar = false,
    window_close_confirmation = 'NeverPrompt',
    window_padding = { top = 25, bottom = 25, left = 34, right = 34 },
})

for _, f in ipairs({ 'mapping', 'font', 'color' }) do
    config = utils.merge(config, require(('conf.%s'):format(f)))
end

-- Load local config if any
local ok, local_conf = pcall(require, 'local')
if ok then config = utils.merge(config, local_conf) end

return config
