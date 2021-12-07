-- Toggle redshift when viewing videos with mpv
if os.execute("command -v redshift-cli >/dev/null") == 0 then
    return
end

-- Consider redshift is enabled when starting
rs_enabled = true

function rs_disable()
    if rs_enabled then
        os.execute("redshift-cli -t >/dev/null")
        rs_enabled = false
        mp.msg.log("info", "Disabling redshift")
    end
end

function rs_enable()
    if not rs_enabled then
        os.execute("redshift-cli -t >/dev/null")
        os.execute("polybar-msg hook redshift 1 >/dev/null")
        rs_enabled = true
        mp.msg.log("info", "Reenabling redshift")
    end
end

function rs_handler()
    if mp.get_property("video") ~= "no" then
        rs_disable()
    else
        rs_enable()
    end
end

mp.register_event("file-loaded", rs_handler)
mp.register_event("shutdown", rs_enable)
