-- local rs   = game:GetService("RunService")
-- local kiru = require(game:GetService("ReplicatedStorage").kiru)
-- local view = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Freecam")

-- local crate = kiru.crate
-- local bus   = kiru.bus.new()
-- local event = kiru.event

-- local fetch = crate.fetch_instance

-- event:add(rs.RenderStepped:Connect(function()
--     local mouse_pos = game:GetService("UserInputService"):GetMouseLocation()
    
--     local frame = fetch("fr", "Frame") {
--         Parent = view,
--         Name = "Frame",
        
--         Size = UDim2.fromOffset(100, 100),
--         Position = UDim2.fromOffset(100, 100),
--     }

--     bus:call("mouse_pos", function(x: number, y: number)
--         frame.Position = UDim2.fromOffset(x, y)
--     end)

--     bus:post("mouse_pos", mouse_pos.X, mouse_pos.Y)
-- end))
