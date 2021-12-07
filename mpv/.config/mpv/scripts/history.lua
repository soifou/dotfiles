-- history
-- Keeps a history log of all files played with mpv.
--
-- Format: "Date Time Path Title" each separated by 3 spaces.
-- Lack of title is indicated by '---'.

local utils = require("mp.utils")

local MPV_DATA_DIR = os.getenv("XDG_DATA_HOME") .. "/mpv"
os.execute("mkdir -p " .. MPV_DATA_DIR)
local MPV_CACHE_DIR = os.getenv("XDG_CACHE_HOME") .. "/mpv"
os.execute("mkdir -p " .. MPV_CACHE_DIR)

local HISTFILE = MPV_DATA_DIR .. "/history.log"
local TMP_HISTFILE = MPV_CACHE_DIR .. "/history.log"
local TMP_ERRORFILE = MPV_CACHE_DIR .. "/load_error.log"

local path
local title

local function write_to_log(file, log)
    local logfile = io.open(file, "a+")
    logfile:write(log)
    logfile:close()
end

mp.register_event("start-file", function()
    title = mp.get_property("media-title")
    path = mp.get_property("path")
end)

-- log files that successfully loaded
mp.register_event("file-loaded", function()
    title = mp.get_property("media-title")
    if not path:find("http.?://") or path:find("magnet:%?") then
        path = utils.join_path(mp.get_property("working-directory"), path)
    end

    log = ("%s\t%s\t%s\n"):format(os.date("%Y-%m-%d %H:%M:%S"), path, title)

    write_to_log(TMP_HISTFILE, log)
    write_to_log(HISTFILE, log)
end)

-- log files that failed to load
mp.register_event("end-file", function(event)
    if event.reason == "error" then
        if not path:find("http.?://") or path:find("magnet:%?") then
            path = utils.join_path(mp.get_property("working-directory"), path)
        end

        log = ("%s\t%s\t%s\n"):format(os.date("%Y-%m-%d %H:%M:%S"), path, title)

        write_to_log(TMP_ERRORFILE, log)
    end
end)
