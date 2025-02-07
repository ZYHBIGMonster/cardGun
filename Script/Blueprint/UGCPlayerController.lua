---@class UGCPlayerController_C:BP_UGCPlayerController_C
--Edit Below--
require("Script.GameHelper.GameHelper")
---@type UGCPlayerController_C
local UGCPlayerController = {}

function UGCPlayerController:GetReplicatedProperties()
    return
end
 
function UGCPlayerController:ReceiveBeginPlay()
    UGCPlayerController.SuperClass.ReceiveBeginPlay(self)
    print("UGCPlayerController:ReceiveBeginPlay")

    if IsServer(self) then
        EGCommonLibrary.OpenTick(self, true)
    else
        PlayerControllerPtr = self
        EGUISystem:Startup(self)
        EGUISystem:OpenUI("CardAndGunMenu")
    end
end

function UGCPlayerController:ReceiveTick(DeltaTime)
    UGCPlayerController.SuperClass.ReceiveTick(self, DeltaTime)
end

---S端
---PlayerController初始化完毕
function UGCPlayerController:UGC_InitializationCompleteEvent()
    print(string.format("UGCPlayerController:UGC_InitializationCompleteEvent PlayerKey[%s]", self.PlayerKey))
end

function UGCPlayerController:ResetCardVote()

end

---客户端请求中转接口(非必要禁止修改)
function UGCPlayerController:ReceiveClientRPC(Param1, ...)
    if not Param1 then
        return
    end

    if type(Param1) == "string" and type(self[Param1]) == "function" then
        self[Param1](...)
    else
        EGServerSystem.ReceiveClientRPC(Param1, ...)
    end
end

function UGCPlayerController:GetAvailableServerRPCs()
    return EGServerSystem.ReceiveClientRPCFuncName
end

--[[
function UGCPlayerController:ReceiveEndPlay()
    UGCPlayerController.SuperClass.ReceiveEndPlay(self) 
end
--]]

return UGCPlayerController