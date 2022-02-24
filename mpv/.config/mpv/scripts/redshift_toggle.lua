-- Toggle redshift when viewing videos with mpv

if os.execute("command -v redshift-cli >/dev/null") == 0 then
    return
end

-- If not explicitly running, don't do anything
local utils = require("mp.utils")
local REDSHIFT_LOCK = os.getenv("XDG_CACHE_HOME") .. "/redshift-cli.lock"
if utils.file_info(REDSHIFT_LOCK) ~= nil then
    return
end

local rs_enabled = true

local function rs_toggle(enabled)
    os.execute("redshift-cli -t >/dev/null")
    os.execute("polybar-msg hook redshift 1 >/dev/null")
    rs_enabled = enabled
end

local function rs_disable()
    if rs_enabled then
        rs_toggle(false)
        mp.msg.log("info", "Disabling redshift")
    end
end

local function rs_enable()
    if not rs_enabled then
        rs_toggle(true)
        mp.msg.log("info", "Reenabling redshift")
    end
end

local function rs_handler()
    if mp.get_property("video") ~= "no" then
        rs_disable()
    else
        rs_enable()
    end
end

local function on_pause_change(name, value)
    rs_toggle(value == true)
end

mp.observe_property("pause", "bool", on_pause_change)
mp.register_event("file-loaded", rs_handler)
mp.register_event("shutdown", rs_enable)
