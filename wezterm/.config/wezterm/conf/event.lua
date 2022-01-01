local wezterm = require("wezterm")

wezterm.on("trigger-vim-with-scrollback", function(window, pane)
    local scrollback = pane:get_lines_as_text()

    local name = os.tmpname()
    local f = io.open(name, "w+")
    f:write(scrollback)
    f:flush()
    f:close()

    local action = wezterm.action({
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
        wezterm.action({
            SplitVertical = {
                args = { "urlpicker", scrollback },
            },
        }),
        pane
    )
end)

wezterm.on("new-3up-tab", function(window, pane)
    window:perform_action(wezterm.action({ SpawnTab = "CurrentPaneDomain" }), pane)
    window:perform_action(wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }), pane)
    window:perform_action(wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }), pane)
    window:perform_action(wezterm.action({ ActivatePaneDirection = "Left" }), pane)
end)
