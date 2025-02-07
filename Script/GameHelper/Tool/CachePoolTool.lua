---@class CachePoolTool
local CachePoolTool = {}
CachePoolTool.MinNum = 1
CachePoolTool.MaxNum = 5
CachePoolTool.__index = CachePoolTool

---创建缓存池，后续不要对缓存池的数据单独操作，尽量使用原生方法
---@param NewObjectHandle function 创建新实例的方式
---@return CachePoolTool
function CachePoolTool.CreatePool(NewObjectHandle, MinNum, MaxNum)
    local Pool = {}
    local Objects = {}

    Pool.MinNum = MinNum or CachePoolTool.MinNum
    Pool.MaxNum = MaxNum or CachePoolTool.MaxNum
    Pool.Objects = Objects
    if type(NewObjectHandle) == "function" then
        Pool.New = NewObjectHandle
    end

    setmetatable(Pool, CachePoolTool)
    Pool:FillPool(Pool.MinNum)
    return Pool
end

---@return any
function CachePoolTool:New()
    return {}
end

---@param Num nil|number
---@return any
function CachePoolTool:Get(Num)
    local Objects = self.Objects
    local PoolNum = #Objects
    local Ret = nil

    if Num then
        Ret = {}
        while Num > 0 do
            if PoolNum > 0 then
                table.insert(Ret, table.remove(Objects, PoolNum))
                PoolNum = PoolNum - 1
            else
                table.insert(Ret, self:New())
            end
        end
    else
        Ret = PoolNum > 0 and table.remove(Objects, PoolNum) or self:New()
    end
    
    self:FillPool(self.MinNum)

    return Ret
end

---只能填充到MaxNum
function CachePoolTool:FillPool(Num)
    local Objects = self.Objects
    local PoolNum = #Objects
    --TODO: 加异步
    for i = 1, PoolNum - (Num or self.MaxNum), 1 do
        self:Add(self:New())
    end
end

function CachePoolTool:Add(Obejct)
    local PoolNum = #self.Objects

    if PoolNum < self.MaxNum then
        table.insert(self.Objects, Obejct)
    else
        for i = 0, PoolNum - self.MaxNum - 1, 1 do
            table.remove(self.Objects, PoolNum - i)
        end
    end
end

function CachePoolTool:Clear()
    self.Objects = {}
end

return CachePoolTool