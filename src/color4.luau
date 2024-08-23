--[[
    Color4, a custom color struct which supports alpha, and functions to apply to instances.
]]

local types = require(script.Parent.types)
local Color4 = {}

function Color4.new(r: number, g: number, b: number, a: number)
    return setmetatable({
        m = "COLOR4",
        r = math.clamp(r, 0, 1),
        g = math.clamp(g, 0, 1),
        b = math.clamp(b, 0, 1),
        a = math.clamp(a, 0, 1),
    }, {__index = Color4})
end

function Color4.fromColor3(color: Color3, alpha: number?)
    return Color4.new(color.R, color.G, color.B, alpha or 1)
end

function Color4.fromHex(hex: string)
    hex = hex:gsub("#", "")
    local r = tonumber(hex:sub(1, 2), 16) :: number / 255
    local g = tonumber(hex:sub(3, 4), 16) :: number / 255
    local b = tonumber(hex:sub(5, 6), 16) :: number / 255
    local a = #hex == 8 and tonumber(hex:sub(7, 8), 16) :: number / 255 or 1
    return Color4.new(r, g, b, a)
end

function Color4:toColor3()
    return Color3.new(self.r, self.g, self.b)
end

function Color4:lerp(goal: types.Color4, alpha: number)
    return Color4.new(
        self.r + (goal.r - self.r) * alpha,
        self.g + (goal.g - self.g) * alpha,
        self.b + (goal.b - self.b) * alpha,
        self.a + (goal.a - self.a) * alpha
    )
end

function Color4:applyToInstance(instance: GuiObject)
    if instance:IsA("GuiObject") then
        instance.BackgroundColor3 = self:toColor3()
        instance.BackgroundTransparency = 1 - self.a
    elseif instance:IsA("TextLabel") or instance:IsA("TextButton") or instance:IsA("TextBox") then
        instance.TextColor3 = self:toColor3()
        instance.TextTransparency = 1 - self.a
    elseif instance:IsA("ImageLabel") or instance:IsA("ImageButton") then
        instance.ImageColor3 = self:toColor3()
        instance.ImageTransparency = 1 - self.a
    end
end

function Color4:toString()
    return string.format("Color4(%f, %f, %f, %f)", self.r, self.g, self.b, self.a)
end

Color4.__add = function(a, b)
    assert(type(a) == "table" and type(b) == "table", "Can only add Color4 to Color4")
    return Color4.new(a.r + b.r, a.g + b.g, a.b + b.b, a.a + b.a)
end

Color4.__sub = function(a, b)
    assert(type(a) == "table" and type(b) == "table", "Can only subtract Color4 from Color4")
    return Color4.new(a.r - b.r, a.g - b.g, a.b - b.b, a.a - b.a)
end

Color4.__mul = function(a, b)
    if type(b) == "number" then
        return Color4.new(a.r * b, a.g * b, a.b * b, a.a * b)
    elseif type(a) == "number" then
        return Color4.new(a * b.r, a * b.g, a * b.b, a * b.a)
    else
        error("Can only multiply Color4 by number")
    end
end

Color4.__div = function(a, b)
    assert(type(b) == "number", "Can only divide Color4 by number")
    return Color4.new(a.r / b, a.g / b, a.b / b, a.a / b)
end

Color4.__eq = function(a, b)
    return a.r == b.r and a.g == b.g and a.b == b.b and a.a == b.a
end

return Color4