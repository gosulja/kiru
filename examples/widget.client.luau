-- local rs = game:GetService("RunService")
-- local kiru = require(game:GetService("ReplicatedStorage").kiru)
-- local types = require(game:GetService("ReplicatedStorage").kiru.types)
-- local view = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Freecam")
-- local bus = kiru.bus.new()
-- local crate = kiru.crate
-- local widget = kiru.widget

-- local Button = setmetatable({}, {__index = widget})
-- -- Button.__index = Button

-- function Button.new(bus: types.Bus, view: Instance)
--     local self = setmetatable(widget.new(bus), {__index = Button})
   
--     self.bus = bus
--     self.view = view
--     self.instance = nil

--     self:setState({
--         hovered = false,
--         clicked = false
--     })

--     return self
-- end

-- function Button:render(text: string)
--     local key = "BUTTON_" .. text
--     self.instance = crate.fetch_instance(key, "TextButton")({
--         Text = text,
--         Parent = self.view,
--         Size = UDim2.new(0, 200, 0, 50),
--         Position = UDim2.new(0.5, -100, 0.5, -25),
--         AutoButtonColor = false,
--         BackgroundColor3 = self:getState("hovered") and Color3.new(0.8, 0.8, 0.8) or Color3.new(0.7, 0.7, 0.7),
--         TextColor3 = Color3.new(0, 0, 0),
--         Font = Enum.Font.SourceSans,
--         TextSize = 18,
       
--         MouseEnter = function()
--             self:setState({ hovered = true })
--         end,

--         MouseLeave = function()
--             self:setState({ hovered = false })
--         end,

--         MouseButton1Click = function()
--             self:setState({ clicked = true })
--         end
--     })

--     local was_clicked = self:getState("clicked")
--     self:setState({ clicked = false })

--     return was_clicked
-- end

-- local ImGui = {
--     _buttons = {},
--     Button = function(self, label: string)
--         if not self._buttons[label] then
--             self._buttons[label] = Button.new(bus, view)
--         end

--         return self._buttons[label]:render(label)
--     end
-- }

-- local function update()
--     if ImGui:Button("Hello, world!") then
--         print("Clicked!")
--     end
-- end

-- rs.RenderStepped:Connect(update)