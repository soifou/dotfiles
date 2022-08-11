local wezterm = require("wezterm")
local act = wezterm.action
local mod = "ALT"

local function map(mods, key, action)
    return { mods = mods, key = key, action = action }
end

local key_tables = {
    resize_pane = {
        { key = "h", action = act.AdjustPaneSize({ "Left", 6 }) },
        { key = "l", action = act.AdjustPaneSize({ "Right", 6 }) },
        { key = "k", action = act.AdjustPaneSize({ "Up", 2 }) },
        { key = "j", action = act.AdjustPaneSize({ "Down", 2 }) },
        -- Cancel the mode by pressing escape
        { key = "Escape", action = "PopKeyTable" },
    },
    select_pane = {
        -- Interactive select and swap
        { key = "w", action = act({ PaneSelect = { alphabet = "0123456789" } }) },
        { key = "s", action = act({ PaneSelect = { mode = "SwapWithActive", alphabet = "0123456789" } }) },
    },
}

local keys = {
    -- Font size
    map(mod, "Backspace", "ResetFontSize"),
    map(mod, "=", "IncreaseFontSize"),
    map(mod, "-", "DecreaseFontSize"),

    -- Scrollback
    map(mod, "d", act({ ScrollByPage = 1 })),
    map(mod, "u", act({ ScrollByPage = -1 })),
    map(mod, "g", "ScrollToTop"),
    map(mod .. "|SHIFT", "g", "ScrollToBottom"),
    map(mod, " ", act({ EmitEvent = "trigger-vim-with-scrollback" })),

    -- Clipboard
    map(mod, "v", act({ PasteFrom = "Clipboard" })),

    -- Windows
    map(mod, "Enter", act({ SplitHorizontal = { domain = "CurrentPaneDomain" } })),
    map("CTRL|" .. mod, "Enter", act({ SplitVertical = { domain = "CurrentPaneDomain" } })),
    map(mod, "q", act({ CloseCurrentPane = { confirm = false } })),
    map(mod, "f", "TogglePaneZoomState"),
    map(mod, "r", act.ActivateKeyTable({ name = 'resize_pane', one_shot = false })),
    map(mod, "w", act.ActivateKeyTable({ name = 'select_pane', one_shot = true })),
    map(mod .. "|SHIFT", "r", act.RotatePanes 'Clockwise'),

    -- Tabs
    map(mod, "t", act({ SpawnTab = "DefaultDomain" })), -- CurrentPaneDomain
    map(mod .. "|SHIFT", "q", act({ CloseCurrentTab = { confirm = false } })),
    map(mod .. "|CTRL", "l", act({ ActivateTabRelative = 1 })),
    map(mod .. "|CTRL", "h", act({ ActivateTabRelative = -1 })),

    -- Wezterm features
    map(mod, "/", act({ Search = { CaseInSensitiveString = "" } })),
    -- map(mod, "l", act({ ClearScrollback = "ScrollbackAndViewport" })),
    -- map(mod, " ", "QuickSelect"),
    -- map("CTRL|ALT", " ", "QuickSelect"), -- note: eats a valid terminal keybind
    -- map(mod .. "|SHIFT", "r", "ReloadConfiguration"),
    map(mod .. "|SHIFT", "d", "ShowDebugOverlay"), -- note: it's not a full Lua interpreter
    map(mod, "x", "ShowLauncher"),

    -- Custom events
    map(mod, "o", act({ EmitEvent = "url-picker" })),
    map(mod .. "|SHIFT", "Enter", act({ EmitEvent = "new-3up-tab" })),
    map(mod .. "|SHIFT", "_", act({ EmitEvent = "toggle-padding" })),
    map(mod .. "|SHIFT", "l", act({ EmitEvent = "toggle-ligatures" })),
}

-- Tabs selection
for i = 1, 9 do
    table.insert(keys, map(mod, tostring(i), act({ ActivateTab = i - 1 })))
end

-- Windows selection
local move_to_pane = function(key, direction)
    return wezterm.action_callback(function(window, pane)
        -- If inside nvim, move to corresponding window (if any)
        -- An instance of nvim needs to be run with the listen directive
        -- $ nvim --listen /tmp/nvim-$TERM-$WEZTERM_PANE
        -- See: https://neovim.io/doc/user/remote.html
        if pane:get_foreground_process_name():sub(-4) == "nvim" then
            local success, stdout, stderr = wezterm.run_child_process({
                "nvim",
                "--server",
                "/tmp/nvim-wezterm" .. "-" .. pane:pane_id(),
                "--remote-expr",
                string.format('v:lua.require("utils").goto_dir("%s")', key),
            })

            wezterm.log_info(stdout, success, stderr)

            -- FIXME: why output of goto_dir returns on stderr, not stdout!?
            -- Exit from here only if valid split
            if success and stderr ~= "" then return end
        end

        -- Else move to corresponding wezterm pane.
        window:perform_action(act.ActivatePaneDirection(direction), pane)
    end)
end

table.insert(keys, map(mod, 'h', move_to_pane('h', 'Left')))
table.insert(keys, map(mod, 'j', move_to_pane('j', 'Down')))
table.insert(keys, map(mod, 'k', move_to_pane('k', 'Up')))
table.insert(keys, map(mod, 'l', move_to_pane('l', 'Right')))

return {
    disable_default_key_bindings = true,
    keys = keys,
    key_tables = key_tables,
    disable_default_mouse_bindings = false,
    mouse_bindings = {
        -- select on pressing down left button
        -- { event={Down={streak=1, button="Left"}},
        --     mods="NONE",
        --     action={SelectTextAtMouseCursor="Cell"}
        -- },
        -- -- extend on dragging the pointer…
        -- { event={Drag={streak=1, button="Left"}},
        --     mods="NONE",
        --     action={ExtendSelectionToMouseCursor="Cell"}
        -- },
        -- -- …or pressing shift and left button,
        -- { event={Down={streak=1, button="Left"}},
        --     mods="SHIFT",
        --     action={ExtendSelectionToMouseCursor={}}
        -- },
        -- -- complete the selection on releasing the left button.
        -- { event={Up={streak=1, button="Left"}},
        --     mods="NONE",
        --     action={CompleteSelection="PrimarySelection"}
        -- },
        --     -- select word on double-click,
        -- { event={Down={streak=2, button="Left"}},
        --     mods="NONE",
        --     action={SelectTextAtMouseCursor="Word"}
        -- },
        -- open link on mod+left click
        {
            event = { Up = { streak = 1, button = "Left" } },
            mods = mod,
            action = "OpenLinkAtMouseCursor",
        },
        -- copy selected text to clipboard
        {
            event = { Up = { streak = 1, button = "Left" } },
            mods = "NONE",
            action = wezterm.action({ CompleteSelection = "Clipboard" }),
        },
        -- copy to clipboard when double-click
        {
            event = { Up = { streak = 2, button = "Left" } },
            mods = "NONE",
            action = wezterm.action({ CompleteSelection = "Clipboard" }),
        },
        -- copy to clipboard when triple-click
        {
            event = { Up = { streak = 3, button = "Left" } },
            mods = "NONE",
            action = wezterm.action({ CompleteSelection = "Clipboard" }),
        },
        -- paste on middle click
        {
            event = { Down = { streak = 1, button = "Middle" } },
            mods = "NONE",
            action = "Paste",
        },
        -- select whole line on triple-click
        {
            event = { Down = { streak = 3, button = "Left" } },
            mods = "NONE",
            action = { SelectTextAtMouseCursor = "Line" },
        },
    },
}
