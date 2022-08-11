local wezterm = require("wezterm")
local act = wezterm.action

local function recompute(window, setting, value)
     local overrides = window:get_config_overrides() or {}
    if not overrides[setting] then
        overrides[setting] = value
    else
        overrides[setting] = nil
    end
    window:set_config_overrides(overrides)
end

wezterm.on("toggle-padding", function(window, _)
    -- https://github.com/wez/wezterm/issues/2044
    recompute(window, 'window_padding', { top = 2, bottom = 2, left = 4, right = 4 })
end)

wezterm.on("toggle-ligatures", function(window, _)
    recompute(window, 'harfbuzz_features', { "calt=0", "clig=0", "liga=0" })
end)

wezterm.on("trigger-vim-with-scrollback", function(window, pane)
    local scrollback = pane:get_lines_as_text()

    local name = os.tmpname()
    local f = io.open(name, "w+")
    f:write(scrollback)
    f:flush()
    f:close()

    local action = act({
        SpawnCommandInNewTab = {
            args = { "nvim", name },
        },
    })
    window:perform_action(action, pane)

    wezterm.sleep_ms(1000)
    os.remove(name)
end)

wezterm.on("url-picker", function(window, pane)
    local scrollback = pane:get_lines_as_text()

    window:perform_action(
        act({ SplitVertical = { args = { "urlpicker", scrollback } } }),
        pane
    )
end)

wezterm.on("new-3up-tab", function(window, pane)
    window:perform_action(act({ SpawnTab = "CurrentPaneDomain" }), pane)
    window:perform_action(act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }), pane)
    window:perform_action(act({ SplitVertical = { domain = "CurrentPaneDomain" } }), pane)
    window:perform_action(act({ ActivatePaneDirection = "Left" }), pane)
end)
