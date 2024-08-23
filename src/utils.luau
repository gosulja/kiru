local function serialize_table(t: {any}): string
    local keys = {}

    for key in pairs(t) do
        table.insert(keys, key)
    end

    table.sort(keys)

    local out = ""
    for _, key in pairs(keys) do
        out = out .. key .. tostring(t[key])
    end

    return out
end


local function hash(str: string): number
    local out = 0

    for i = 1, #str do
        out = (out * 32 + string.byte(str, i)) % 2^32
    end

    return out
end

return {
    serialize_table = serialize_table,
    hash = hash,
}