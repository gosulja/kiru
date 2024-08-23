--[[

    Crate, contains all of the widgets created, sorting them by their ID.

]]

local crate = {}

local utils  = require(script.Parent.utils)
local events = require(script.Parent.events)

local instance_pool  = {}
local previous_props = {}

-- Creates a new instance or returns it.
local function isInstance(value)
    return type(value) == "table" and value.instance
end

function crate.fetch_instance(key: string, class_name: string)
    key = tostring(utils.hash(key .. class_name))
    if not instance_pool[key] then
        instance_pool[key] = Instance.new(class_name)
        instance_pool[key].Name = key
    end
    
    if not previous_props[key] then
        previous_props[key] = {}
    end

    local function apply_color4(inst: Instance, prop: string, color4)
        if prop:find("Color3") then
            inst[prop] = color4:toColor3()
            local transparency = prop:gsub("Color3", "Transparency")
            if inst[transparency] ~= nil then
                inst[transparency] = 1 - color4.a
            end
        else
            warn(`[Kiru::crate::Warn] unsupported Color4 property: '{prop}'`)
        end
    end

    local function process_children(parent, children)
        for _, child in ipairs(children) do
            if isInstance(child) then
                child.instance.Parent = parent
            elseif type(child) == "function" then
                local result = child()
                if isInstance(result) then
                    result.instance.Parent = parent
                end
            end
        end
    end

    return function(properties: {[string]: any})
        local instance = instance_pool[key]
        local children = properties.Children or {}
        properties.Children = nil

        for prop, value in pairs(properties) do
            if prop ~= "Parent" then
                if typeof(instance[prop]) == "RBXScriptSignal" then
                    if typeof(value) == "function" then
                        if previous_props[key][prop .. "_connection"] then
                            previous_props[key][prop .. "_connection"]:Disconnect()
                            events:remove(previous_props[key][prop .. "_connection"])
                        end
   
                        local connection = (instance[prop] :: RBXScriptSignal):Connect(function(...)
                            value(instance, ...)
                        end)
                        previous_props[key][prop .. "_connection"] = connection
                        events:add(connection)
                    end
                elseif isInstance(value) then
                    instance[prop] = value.instance
                elseif typeof(value) == "table" and value.m == "COLOR4" then
                    apply_color4(instance, prop, value)
                else
                    instance[prop] = value
                end
            end
        end

        process_children(instance, children)

        if properties.Parent then
            instance.Parent = properties.Parent
        end

        return {
            instance = instance,
            key = key
        }
    end
end

-- Removes the instance and destroys it from the pool
function crate.remove_instance(key: number)
    if instance_pool[key] then
        for _, connection in pairs(previous_props[key] or {}) do
            if typeof(connection) == "RBXScriptConnection" then
                connection:Disconnect()
                events:remove(connection)
            end
        end

        instance_pool[key]:Destroy()
        instance_pool[key] = nil
        
        return true, `Successfully removed instance {key}`
    end

    return false, `Unable to remove instance {key}, it most likely doesn't exist.`
end

-- Flushes the instance pool, and clears all tables
function crate.flush()
    for i = 1, #instance_pool do
        instance_pool[i]:Destroy()
        instance_pool[i] = nil
    end

    table.clear(previous_props)
end

return crate