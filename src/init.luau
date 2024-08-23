local rs     = game:GetService("RunService")
local crate  = require(script.crate)
local events = require(script.events)
local bus    = require(script.bus)

local Button = require(script.widgets.button)

-- Kiru context
local Kiru = {
    bus = bus.new(),
    widgets = {},
}

function Kiru:CreateContext(options: {[string]: any})
    if not self.view then
        self.view = if options.debug then options.target else crate.fetch_instance("view", "ScreenGui")({
            Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"),
            IgnoreGuiInset = true,
            ResetOnSpawn = false,
        })
    end
end

function Kiru:Button(label: string): boolean
    if not self.widgets["BUTTON_" .. label] and self.view then
        self.widgets["BUTTON_" .. label] = Button.new(bus, self.view)
    end

    return self.widgets["BUTTON_" .. label]:render(label)
end

function Kiru:Update(fn: () -> ())
    local handler = rs.RenderStepped:Connect(fn)

    return function()
        handler:Disconnect()
        events:clear()
        crate.flush()
    end
end

return Kiru