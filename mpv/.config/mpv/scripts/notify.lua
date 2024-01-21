-- notify
-- Sends a desktop notification when file loaded or failed to load.

local notify_cmd = 'notify-send -i /usr/share/icons/Papirus/32x32/apps/mpvz.svg'

mp.register_event('file-loaded', function()
    local title = mp.get_property('media-title')

    if  title == mp.get_property('filename') then
        title = mp.get_property('path')
    end

    os.execute(
        ("%s -u low 'Watching now' '%s'"):format(
            notify_cmd,
            string.gsub(title, "'", "'\"'\"'")
        )
    )
end)

-- Send notification when failed to open file.
mp.register_event('end-file', function(event)
    if event.reason == 'error' then
        os.execute(("%s Error 'Fails to open file!'"):format(notify_cmd))
    end
end)
