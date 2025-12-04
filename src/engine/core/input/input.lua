local InputService = class("InputService")
local Signals = require("lib.signals")

InputService.Mapping = {
    keypressed      = "_on_key_press",
    keyreleased     = "_on_key_release",
    textinput       = "_on_text_input",
    mousepressed    = "_on_mouse_click",
    mousereleased   = "_on_mouse_release",
    mousemoved      = "_on_mouse_move",
    wheelmoved      = "_on_mouse_wheel_move",
    joystickadded   = "_on_joystick_add",
    joystickremoved = "_on_joystick_remove",
}

function InputService:init()
    self.signals = Signals:new()
    self:setup()
end

function InputService:setup()
    for k,v in pairs(InputService.Mapping) do
        love[k] = function(...)
            self:emit(v,...)
        end
    end
end

function InputService:on(name,...)
    return self.signals:on(name,...)
end

function InputService:emit(name,...)
    self.signals:emit(name,...)
end

return {InputService=InputService:new()}