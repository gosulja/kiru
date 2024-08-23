local crate  = require(script.Parent.crate)
local types  = require(script.Parent.types)

local Widget = {}

function Widget.new(bus: types.Bus)
    local self = setmetatable({}, {__index=Widget})
    
    self.bus = bus
    self.instance = nil
    self.changed = false
    self.crate = crate
    self.state = {}

    self:setState({
        visible = true,
        active  = true,
        pressed = false,
        hovered = false,
    })

    return self
end

function Widget:setState(new_state: {[string]: any})
    local has_change = false
    for i, v in pairs(new_state) do
        if self.state[i] ~= v or not self.state[i] then
            self.state[i] = v
            has_change = true
        end
    end

    if has_change then
        self.changed = true
    end
end

function Widget:getState(state: string)
    return self.state[state] or false
end

function Widget:setInstance(instance: Instance)
    assert(instance, "[Kiru::widget::Error] setInstance failed to get 'instance'")
    self.instance = instance
end

function Widget:render()
    warn("[Kiru::widget::Warn] render method not implemented.")
end

return Widget
