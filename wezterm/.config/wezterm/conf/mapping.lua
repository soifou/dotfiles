local wezterm = require("wezterm")
local act = wezterm.action

local function act_callback(event_id, callback)
    if wezterm.action_callback then
        wezterm.log_info(">> wezterm.action_callback is available for this version, use it!")
        return wezterm.action_callback(callback)
    else
        wezterm.log_info(">> wezterm.action_callback is NOT available for this version, fallback to manual setup..")
        wezterm.on(event_id, callback)
        return wezterm.action({ EmitEvent = event_id })
    end
end

local function map(mods, key, action)
    return { mods = mods, key = key, action = action }
end

local mod = "ALT"

return {
    disable_default_key_bindings = true,
    keys = {
        -- Font size
        map(mod, "Backspace", "ResetFontSize"),
        map(mod, "=", "IncreaseFontSize"),
        map(mod, "-", "DecreaseFontSize"),

        -- Scrollback
        map(mod, "k", act({ ScrollByPage = -1 })),
        map(mod, "j", act({ ScrollByPage = 1 })),
        map(mod, " ", act({ EmitEvent = "trigger-vim-with-scrollback" })),

        -- Clipboard
        map(mod, "v", act({ PasteFrom = "Clipboard" })),

        -- Windows
        map(mod, "Enter", act({ SplitHorizontal = { domain = "CurrentPaneDomain" } })),
        map("CTRL|" .. mod, "Enter", act({ SplitVertical = { domain = "CurrentPaneDomain" } })),
        map(mod .. "|SHIFT", "q", act({ CloseCurrentPane = { confirm = false } })),
        map(mod .. "|SHIFT", "l", act({ ActivatePaneDirection = "Right" })),
        map(mod .. "|SHIFT", "h", act({ ActivatePaneDirection = "Left" })),
        map(mod .. "|SHIFT", "k", act({ ActivatePaneDirection = "Up" })),
        map(mod .. "|SHIFT", "j", act({ ActivatePaneDirection = "Down" })),

        -- Tabs
        map(mod, "t", act({ SpawnTab = "DefaultDomain" })), -- CurrentPaneDomain
        map(mod, "q", act({ CloseCurrentTab = { confirm = false } })),
        map(mod, "l", act({ ActivateTabRelative = 1 })),
        map(mod, "h", act({ ActivateTabRelative = -1 })),

        -- Wezterm features
        map(mod, "r", "ReloadConfiguration"),
        -- map(mod, "l", act({ ClearScrollback = "ScrollbackAndViewport" })),
        map(mod, "f", act({ Search = { CaseInSensitiveString = "" } })),
        -- map(mod, " ", "QuickSelect"),
        -- map("CTRL|ALT", " ", "QuickSelect"), -- note: eats a valid terminal keybind
        map(mod, "d", "ShowDebugOverlay"), -- note: it's not a full Lua interpreter
        map(mod, "x", "ShowLauncher"),

        -- Custom events
        map(mod, "u", act({ EmitEvent = "url-picker" })),
        map(mod .. "|SHIFT", "Enter", act({ EmitEvent = "new-3up-tab" })),
        map(
            mod,
            "g",
            act_callback("toggle-ligatures", function(win, _)
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
    },
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
