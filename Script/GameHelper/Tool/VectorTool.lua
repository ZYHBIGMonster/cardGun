---@class VectorTool
local VectorTool = {}

function VectorTool.Dot(v1, v2)
    return v1.X * v2.X + v1.Y * v2.Y + v1.Z * v2.Z
end

function VectorTool.Mul(v1, v2)
    return Vector.New(v1.X * v2.X, v1.Y * v2.Y, v1.Z * v2.Z)
end

function VectorTool.MulNumber(v1, number)
    return Vector.New(v1.X * number, v1.Y * number, v1.Z * number)
end

function VectorTool.Sub(v1, v2)
    return Vector.New(v1.X - v2.X, v1.Y - v2.Y, v1.Z - v2.Z)
end

function VectorTool.Add(v1, v2)
    return Vector.New(v1.X + v2.X, v1.Y + v2.Y, v1.Z + v2.Z)
end

function VectorTool.ToString(v)
    return string.format("(%.2f,%.2f,%.2f)", v.X, v.Y, v.Z)
end

function VectorTool.Cross(v1, v2)
    return Vector.New(v1.Y * v2.Z - v2.Y * v1.Z,
        v1.Z * v2.X - v2.Z * v1.X,
        v1.X * v2.Y - v2.X * v1.Y)
end

function VectorTool.GetDistance(vector1, vector2)
    if vector1 == nil or vector2 == nil then return 0 end
    if vector1.X == nil or vector2.X == nil then return 0 end
    if vector1.Y == nil or vector2.Y == nil then return 0 end
    if vector1.Z == nil or vector2.Z == nil then return 0 end
    local disX = vector1.X - vector2.X
    local disY = vector1.Y - vector2.Y
    local disZ = vector1.Z - vector2.Z
    return math.sqrt(disX ^ 2 + disY ^ 2 + disZ ^ 2)
end

function VectorTool.GetDistance2D(vector1, vector2)
    if vector1 == nil or vector2 == nil then return 0 end
    if vector1.X == nil or vector2.X == nil then return 0 end
    if vector1.Y == nil or vector2.Y == nil then return 0 end
    local disX = vector1.X - vector2.X
    local disY = vector1.Y - vector2.Y
    return math.sqrt(disX ^ 2 + disY ^ 2)
end

function VectorTool.LengthSquared(v)
    return v.X ^ 2 + v.Y ^ 2 + v.Z ^ 2
end

function VectorTool.Length(v)
    return math.sqrt(VectorTool.LengthSquared(v))
end

function VectorTool.ToLuaTable(v)
    return {X = v.X, Y = v.Y, Z = v.Z}
end

function VectorTool.RotToLuaTable(v)
    return {Roll=v.Roll, Pitch=v.Pitch, Yaw=v.Yaw}
end


function VectorTool.GetMiddlePoint(vector1, vector2)
    return {X = (vector1.X + vector2.X) / 2, Y = (vector1.Y + vector2.Y) / 2,Z = (vector1.Z + vector2.Z) / 2}
end

return VectorTool