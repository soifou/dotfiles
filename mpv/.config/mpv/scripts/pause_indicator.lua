-- Add pause indicator
-- Credit: https://github.com/zydezu/ModernX/issues/46#issuecomment-2380348608

local pause_ind = mp.create_osd_overlay('ass-events')
pause_ind.data = [[{\an5\p1\alpha&H79\1c&Hffffff&\3a&Hff\pos(760,440)}]]
    .. [[m-145 -75 l -105 -75 l -105 75 l -145 75 m-55 -75 l -15 -75 l -15 75 l -55 75]]

mp.observe_property('pause', 'bool', function(_, paused)
    mp.add_timeout(0.1, function()
        if paused then
            pause_ind:update()
        else
            pause_ind:remove()
        end
    end)
end)
