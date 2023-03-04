local M = {}

local function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

M.merge = function(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end
    return t1
end

M.recompute = function(window, setting, value)
    local overrides = window:get_config_overrides() or {}
    -- print(dump(overrides))
    if not overrides[setting] then
        overrides[setting] = value
    else
        overrides[setting] = nil
    end
    window:set_config_overrides(overrides)
end

M.scandir = function(directory)
    local i, t, popen = 0, {}, io.popen
    local f = popen('ls --ignore="%^." "' .. directory .. '"')
    for filename in f:lines() do
        i = i + 1
        t[i] = directory .. '/' .. filename
    end
    f:close()
    return t
end

return M
