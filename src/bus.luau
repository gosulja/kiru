--[[

    Bus, a custom event system for widgets.

]]

local types = require(script.Parent.types)
local Bus = {}

function Bus.new()
    local self = setmetatable({}, {__index=Bus})
    self._listeners = {}
    return self
end

function Bus:subscribe(event_name: string, handler: types.Handler)
    assert(self._listeners, "listeners is nil, did you call .new()?")
    if not self._listeners[event_name] then
        self._listeners[event_name] = {}
    end

    table.insert(self._listeners[event_name], handler)
end

function Bus:post(event_name: string, ...: any)
    local handlers = self._listeners[event_name]
    if handlers then
        for _, handler in pairs(handlers) do
            local s, e = pcall(handler, ...)
            if not s and e then
                error(`[Kiru::bus::Error] {e}`)
            end
        end
    else
        error(`[Kiru::bus::Error] Unable to find event '{event_name}'`)
    end
end

function Bus:remove(event_name: string, handler: types.Handler)
    local handlers = self._listeners[event_name]
    if handlers then
        for i, h in ipairs(handlers) do
            if h == handler then
                table.remove(handlers, i)
                break
            end
        end
    end
end

function Bus:clear(event_name: string)
    self._listeners[event_name] = nil
end

function Bus:has_listeners(event_name: string)
    return self._listeners[event_name] and #self._listeners[event_name] > 0
end

return Bus