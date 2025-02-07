---@class UGCGameMode_C:BP_UGCGameBase_C
--Edit Below--
require("Script.GameHelper.GameHelper")
---@type UGCGameMode_C
local UGCGameMode = {}; 

function UGCGameMode:ReceiveBeginPlay()
    print("UGCGameMode:ReceiveBeginPlay")

    GameModePtr = self

    --关闭伤害
    self.bEnableDamage = false
end

-- function UGCGameMode:ReceiveTick(DeltaTime)

-- end
-- function UGCGameMode:ReceiveEndPlay()
 
-- end
return UGCGameMode;