local wezterm = require("wezterm")
local act = wezterm.action
local mod = "ALT"

local function map(mods, key, action)
    return { mods = mods, key = key, action = action }
end

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

    -- Tabs
    map(mod, "t", act({ SpawnTab = "DefaultDomain" })), -- CurrentPaneDomain
    map(mod .. "|SHIFT", "q", act({ CloseCurrentTab = { confirm = false } })),
    map(mod .. "|CTRL", "l", act({ ActivateTabRelative = 1 })),
    map(mod .. "|CTRL", "h", act({ ActivateTabRelative = -1 })),

    -- Wezterm features
    map(mod, "r", "ReloadConfiguration"),
    map(mod, "f", act({ Search = { CaseInSensitiveString = "" } })),
    -- map(mod, "l", act({ ClearScrollback = "ScrollbackAndViewport" })),
    -- map(mod, " ", "QuickSelect"),
    -- map("CTRL|ALT", " ", "QuickSelect"), -- note: eats a valid terminal keybind
    map(mod .. '|SHIFT', "d", "ShowDebugOverlay"), -- note: it's not a full Lua interpreter
    map(mod, "x", "ShowLauncher"),

    -- Custom events
    map(mod, "o", act({ EmitEvent = "url-picker" })),
    map(mod .. "|SHIFT", "Enter", act({ EmitEvent = "new-3up-tab" })),
    map(mod .. "|SHIFT", "l", wezterm.action_callback(function(win, _)
            local overrides = win:get_config_overrides() or {}
            if not overrides.harfbuzz_features then
                -- If we haven't overriden it yet, then override with ligatures disabled
                overrides.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
            else
                -- else we did already, and we should disable the override now
                overrides.harfbuzz_features = nil
            end
            win:set_config_overrides(overrides)
        end)
    ),
}

-- Tabs selection
for i = 1, 9 do
    table.insert(keys, {
        key = tostring(i),
        mods = mod,
        action = act({ ActivateTab = i - 1 }),
    })
end

-- Move between terminal panes and vim splits seamlessly
-- FIXME: Currently not able to control pane from external program (here vim)
-- So we cannot go out from a vim split to a neighbour terminal pane
-- See discussion: https://github.com/wez/wezterm/discussions/995
local basename = function(s)
    return string.gsub(s, "(.*[/\\])(.*)", "%2")
end
local is_vim = function(pane)
    local proc = basename(pane:get_foreground_process_name())
    wezterm.log_info("@is_vim, proc=" .. proc)
    return proc == "nvim" or proc == "vim" or proc == "dash"
end
for k, v in pairs({ h = "Left", j = "Down", k = "Up", l = "Right" }) do
    table.insert(keys, {
        key = k,
        mods = "ALT",
        action = wezterm.action_callback(function(window, pane)
            if is_vim(pane) then
                window:perform_action(act({ SendKey = { key = k, mods = mod } }), pane)
            else
                window:perform_action(act({ ActivatePaneDirection = v }), pane)
            end
        end),
    })
end

return {
    disable_default_key_bindings = true,
    keys = keys,
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
