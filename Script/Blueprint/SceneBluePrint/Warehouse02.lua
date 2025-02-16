---@class Warehouse02_C:BP_Bootcamp_Warehouse_02_C
--Edit Below--
local Warehouse02 = {}
 
--[[
function Warehouse02:ReceiveBeginPlay()
    Warehouse02.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Warehouse02:ReceiveTick(DeltaTime)
    Warehouse02.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Warehouse02:ReceiveEndPlay()
    Warehouse02.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Warehouse02:GetReplicatedProperties()
    return
end
--]]

--[[
function Warehouse02:GetAvailableServerRPCs()
    return
end
--]]

return Warehouse02