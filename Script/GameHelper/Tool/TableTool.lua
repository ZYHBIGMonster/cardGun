---@class TableTool
local TableTool = {
    
}

-------------------------------------------------------------LuaTable处理-------------------------------------------------------------------

---深拷贝
---@param obj any
---@return table
function TableTool:DeepCopy(obj)
    local InTable = {};
    local function Func(obj)
        if type(obj) ~= "table" then   --判断表中是否有表
            return obj;
        end
        if InTable[obj] then    --已拷贝
            return InTable[obj]
        end
        local NewTable = {};  --定义一个新表
        InTable[obj] = NewTable;  --若表中有表，则先把表给InTable，再用NewTable去接收内嵌的表
        for k,v in pairs(obj) do  --把旧表的key和Value赋给新表
            NewTable[Func(k)] = Func(v);
        end
        return setmetatable(NewTable, getmetatable(obj))  --赋值元表
    end
    return Func(obj) --若表中有表，则把内嵌的表也复制了
end

---得到表中随机的一个key
---@param tab table<any,number|string>
---@return any
function TableTool:GetRandomObject(tab)
    local RandomWeight = math.random(0, TableTool:GetTotal(tab))
    for k, v in pairs(tab) do
        local Weight = tonumber(v)
        if Weight and Weight > 0 then
            RandomWeight = RandomWeight - Weight
            if RandomWeight <= 0 then
                return k
            end
        end
    end
end

---计算表中数字总和
---@param tab table<any,number|string>
---@return number
function TableTool:GetTotal(tab)
    local TotalWeight = 0
    for k, v in pairs(tab) do
        local Weight = tonumber(v)
        if Weight and Weight > 0 then
            TotalWeight = TotalWeight + Weight
        end
    end
    return TotalWeight
end

-------------------------------------------------------------DataTable处理-------------------------------------------------------------------



return TableTool