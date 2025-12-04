local Signals = class("Signals")
local Logging = require("lib.logging").Logging

function Signals:init()
    self._signals = {}
end

function Signals:emit(name,...)
    if not self._signals[name:lower()] then self._signals[name:lower()] = {} end
    local sigs = self._signals[name:lower()]
    if #sigs == 0 then Logging.WARN("No listeners for event " .. name:lower()) return end
    for i=1,#sigs do
        sigs[i](...)
    end
end

function Signals:on(name,fn)
    if type(fn) ~= "function" then Logging.ERROR("Argument passed to Node:on is not a function") end
    if not self._signals[name:lower()] then self._signals[name:lower()] = {} end
    table.insert(self._signals[name:lower()],fn)
end

return Signals