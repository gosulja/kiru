--[[

    Events, a simple roblox signal connection manager.

]]

local Events = {}

local connections = {} -- stores all connections added

function Events:add(connection: RBXScriptConnection)
    if connection and typeof(connection) == "RBXScriptConnection" then
        table.insert(connections, connection)
    else
        warn(`[Kiru::events::Warn] Invalid connection provided. Expected RBXScriptConnection.`)
    end
end

function Events:remove(connection: RBXScriptConnection)
    for i, conn in ipairs(connections) do
        if conn == connection then
            conn:Disconnect()
            table.remove(connections, i)
            return
        end
    end
    warn(`[Kiru::events::Warn] Connection not found.`)
end

function Events:clear()
    for _, connection in pairs(connections) do
        connection:Disconnect()
    end
    connections = {}
end

return Events
