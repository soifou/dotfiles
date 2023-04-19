local wezterm = require("wezterm")
local act = wezterm.action
local recompute = require('utils').recompute

return {
    attach = function()
        wezterm.on("toggle-padding", function(window, _)
            -- https://github.com/wez/wezterm/issues/2044
            recompute(window, 'window_padding', { top = 0, bottom = 0, left = 4, right = 4 })
        end)

        wezterm.on("toggle-ligatures", function(window, _)
            recompute(window, 'harfbuzz_features', { "calt=0", "clig=0", "liga=0" })
        end)

        -- Toggle the font size when using vim "zen mode"
        -- See: https://github.com/wez/wezterm/discussions/2550
        -- This use the special event "user-var-changed"
        -- https://wezfurlong.org/wezterm/config/lua/window-events/user-var-changed.html
        wezterm.on('user-var-changed', function(window, pane, name, value)
            local overrides = window:get_config_overrides() or {}
            if name == "ZEN_MODE" then
                local incremental = value:find("+")
                local number_value = tonumber(value)
                if incremental ~= nil then
                    while (number_value > 0) do
                        window:perform_action(wezterm.action.IncreaseFontSize, pane)
                        number_value = number_value - 1
                    end
                    overrides.enable_tab_bar = false
                elseif number_value < 0 then
                    window:perform_action(wezterm.action.ResetFontSize, pane)
                    overrides.font_size = nil
                    overrides.enable_tab_bar = true
                else
                    overrides.font_size = number_value
                    overrides.enable_tab_bar = false
                end
            end
            window:set_config_overrides(overrides)
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
    end
}
