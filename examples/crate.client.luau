-- local kiru = require(game:GetService("ReplicatedStorage").kiru)
-- local view = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Freecam")

-- --[[

--     Using Kiru's crate system. Instance management tailored for IMGUI.

-- ]]

-- --[[ EXAMPLE ]]

-- local crate = kiru.crate
-- local fetch = crate.fetch_instance

-- while task.wait() do
--     fetch("key", "Frame") {
--         Parent = view,
--         Name = "Frame",
--         Size = UDim2.fromOffset(100, 100),
--         Position = UDim2.fromOffset(100, 100),
--         BackgroundColor3 = Color3.fromRGB(255, 0, 0),

--         MouseEnter = function(rbx) 
--             rbx.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
--         end,

--         MouseLeave = function(rbx) 
--             rbx.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
--         end,
--     }
-- end

-- crate.flush()
