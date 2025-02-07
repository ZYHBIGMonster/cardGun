---@class UGCPlayerState_C:BP_UGCPlayerState_C
--Edit Below--
local UGCPlayerState = {}

function UGCPlayerState:GetReplicatedProperties()
    return
end

function UGCPlayerState:ReceiveBeginPlay()
    UGCPlayerState.SuperClass.ReceiveBeginPlay(self)
end


function UGCPlayerState:ReceiveTick(DeltaTime)
    UGCPlayerState.SuperClass.ReceiveTick(self, DeltaTime)
end

--[[
function UGCPlayerState:ReceiveEndPlay()
    UGCPlayerState.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function UGCPlayerState:GetAvailableServerRPCs()
    return
end
--]]

return UGCPlayerState