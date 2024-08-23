local widget = require(script.Parent.Parent.widget)
local types = require(script.Parent.Parent.types)
local crate = require(script.Parent.Parent.crate)
local style = require(script.Parent.Parent.style)

local Button = setmetatable({}, {__index = widget})
local fetch = crate.fetch_instance

function Button.new(bus: types.Bus, view: Instance)
    local self = setmetatable(widget.new(bus), {__index = Button})
   
    self.bus = bus
    self.view = view
    self.instance = nil

    self:setState({
        hovered = false,
        clicked = false
    })

    return self
end

function Button:render(text: string)
    local key = "BUTTON_" .. text

    -- selene: allow(mixed_table)
    self.instance = fetch(key, "TextButton")({
        Text             = text,
        Parent           = self.view,
        Size             = UDim2.new(0, 100, 0, 30),
        AutomaticSize    = Enum.AutomaticSize.X,
        Position         = UDim2.new(0.5, -100, 0.5, -25),
        AutoButtonColor  = false,

        BackgroundColor3 = self:getState("hovered") and style.Colors.ButtonHovered or style.Colors.Button,
        TextColor3       = style.Colors.Text,

        FontFace         = style.FontFaces.Rubik,
        TextSize         = 14,
       
        MouseEnter       = function()
            self:setState({ hovered = true })
        end,

        MouseLeave       = function()
            self:setState({ hovered = false })
        end,
        
        MouseButton1Click = function()
            self:setState({ clicked = true })
        end,

        Children = {
            fetch(key .. "padding", "UIPadding")({
                PaddingLeft = UDim.new(0, 5),
                PaddingRight = UDim.new(0, 5),
            })
        }
    })

    local was_clicked = self:getState("clicked")
    self:setState({ clicked = false })

    return was_clicked
end

return Button