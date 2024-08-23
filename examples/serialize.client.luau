-- local kiru = require(game:GetService("ReplicatedStorage").kiru)


-- --[[

--     Serializing widgets properties / states to be hashed, to detect widget changes.

-- ]]

-- --[[ EXAMPLE ]]

-- local properties = {
--     visible = true,
--     active  = true,
--     hovered = false,
--     clicked = false,    
-- }

-- local serialized = kiru.utils.serialize_table(properties)

-- print(`Serialized Widget Properties: {serialized}`)

-- local hashed = kiru.utils.hash(serialized)

-- print(`Hashed Widget serialization: {hashed}`)

-- --[[ Detecting changes. ]]

-- properties.visible = false

-- local serialized2 = kiru.utils.serialize_table(properties)

-- print(`Changed Widget properties: {serialized2}`)

-- local hashed2 = kiru.utils.hash(serialized2)

-- print(`Hashed2 Widget serialization: {hashed2}`)

-- print(`serialized2 == serialized2 : {serialized == serialized2}`)
-- print(`hashed == hashed2 : {hashed == hashed2}`)