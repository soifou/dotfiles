local xres_colors = function()
    local output = io.popen("xrdb -query")
    local query = output:read("*a")
    output:close()

    local scheme = {}
    for i, color in string.gmatch(query, "*.color(%d+):[^#]*(#[%a%d]+)") do
        scheme["color" .. i] = color
    end

    scheme.background = string.match(query, "*.background:[^#]*(#[%a%d]+)")
    scheme.foreground = string.match(query, "*.foreground:[^#]*(#[%a%d]+)")

    -- local theme = string.match(query, "*.theme:[%s]+([%a]+)")
    -- if theme ~= nil then
    --     scheme.theme = theme
    -- end

    return scheme
end
local xrdb = xres_colors()

local function hexToRgb(hex_str)
    local hex = "[abcdef0-9][abcdef0-9]"
    local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
    hex_str = string.lower(hex_str)

    assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

    local r, g, b = string.match(hex_str, pat)
    return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

local function blend(fg, bg, alpha)
    bg = hexToRgb(bg)
    fg = hexToRgb(fg)

    local blendChannel = function(i)
        local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

local function darken(hex, amount, bg)
    return blend(hex, bg or xrdb.background, math.abs(amount))
end

local function lighten(hex, amount, fg)
    return blend(hex, fg or xrdb.foreground, math.abs(amount))
end

return {
    colors = {
        foreground = xrdb.foreground,
        background = xrdb.background,
        cursor_bg = xrdb.color3,
        cursor_fg = "black",
        cursor_border = xrdb.color5,
        selection_fg = xrdb.color3,
        selection_bg = lighten(xrdb.background, 0.97),
        scrollbar_thumb = "#222222",
        split = lighten(xrdb.background, 0.90),
        ansi = {
            xrdb.color0,
            xrdb.color1,
            xrdb.color2,
            xrdb.color3,
            xrdb.color4,
            xrdb.color5,
            xrdb.color6,
            xrdb.color7,
        },
        brights = {
            xrdb.color8,
            xrdb.color9,
            xrdb.color10,
            xrdb.color11,
            xrdb.color12,
            xrdb.color13,
            xrdb.color14,
            xrdb.color15,
        },
        tab_bar = {
            background = xrdb.background,
            active_tab = {
                bg_color = xrdb.color4,
                fg_color = xrdb.background,
            },
            inactive_tab = {
                bg_color = xrdb.background,
                fg_color = xrdb.color4,
            },
            inactive_tab_hover = {
                bg_color = "#1A1B26",
                fg_color = "#C0CAF5",
            },
            new_tab = {
                bg_color = "#13141C",
                fg_color = "#565F89",
            },
            new_tab_hover = {
                bg_color = "#1A1B26",
                fg_color = "#C0CAF5",
            },
        },
    },
}
