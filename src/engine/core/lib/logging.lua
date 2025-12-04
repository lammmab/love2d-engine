local new_color3 = require("math.color").new_color3

local Logging = {}
Logging.LogType = {
    DEBUG = 1,
    ERROR = 2,
    WARN = 3,
    INFO = 4,
    SUCCESS = 5
}
Logging.Colors = {
    [1] = new_color3(72,101,129),
    [2] = new_color3(255, 99, 71),
    [3] = new_color3(255, 255, 153),
    [4] = new_color3(203, 203, 203),
    [5] = new_color3(0, 158, 96)
}

local function rgb_to_ansi(r, g, b)
    return string.format("\27[38;2;%d;%d;%dm", r, g, b)
end

local reset_ansi = "\27[0m"

function Logging.colorify(text,color)
    if typeof(color) ~= "color" then error("Can't colorify non-color object") end
    return rgb_to_ansi(color.r,color.g,color.b) .. text .. reset_ansi
end

function Logging.format_text(type_name,text,color)
    local formatted_text = string.format("[%s]: %s", type_name, text)
    return Logging.colorify(formatted_text,color)
end

local DEBUG_MODE = false

function Logging.toggle_debug(val)
    val = val == true
    DEBUG_MODE = val
end

local function log_print(k,msg,v)
    local formatted = Logging.format_text(k,msg,Logging.Colors[v])
    print(formatted)
end

local function log_error(k,msg,v)
    error(Logging.format_text(k,msg,Logging.Colors[v]))
end

for k,v in pairs(Logging.LogType) do
    Logging[k] = function (msg)
        if k == "DEBUG" then if DEBUG_MODE == true then log_print(k,msg,v) else return end end
        if k == "ERROR" then log_error(k,msg,v) end
        log_print(k,msg,v)
    end
end


return {
    Logging=Logging
}