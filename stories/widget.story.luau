local kiru = require(game:GetService("ReplicatedStorage").kiru)

return function(target: Frame)
    kiru:CreateContext({ debug = true, target = target })
    
    local handler = kiru:Update(function()

        if kiru:Button("helloooooooooooooooooooo") then
            print("hello, world!")
        end

    end)

    return handler
end