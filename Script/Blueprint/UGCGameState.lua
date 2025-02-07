---@class UGCGameState_C:BP_UGCGameState_C
--Edit Below--
UGCGameSystem.UGCRequire('Script.Common.ue_enum_custom')
require("Script.GameHelper.GameHelper")
---@type UGCGameState_C
local UGCGameState = 
{
    RoundCards = {};
}; 

function UGCGameState:GetReplicatedProperties()
    return
    "RoundCards"
end

function UGCGameState:ReceiveBeginPlay()
    print("UGCGameState:ReceiveBeginPlay")
    GameStatePtr = self
end

function UGCGameState:ReceiveTick(DeltaTime)
    EGEventSystem:SendEvent(EGEventType.ReceiveTick, DeltaTime)
end

function UGCGameState:DealCards(RoundNum)
    local CardCount = 5
    local CardConfig = require("Script.Config.CardConfig")
    local CardPool = EGTableTool:DeepCopy(CardConfig.RoundCardPool[RoundNum])
    local Cards = {}

    while CardCount > 0 do
        local CardID = EGTableTool:GetRandomObject(CardPool)
        if CardID then
            table.insert(Cards, CardID)
        else
            print("[LuaException] UGCGameState:DealCards CardID is nil")
        end
    end

    self.RoundCards = Cards
end

function UGCGameState:OnRep_RoundCards()
    EGEventSystem:SendEvent(EGEventType.OnRoundCardsChanged, self.RoundCards)
end

-- function UGCGameState:ReceiveEndPlay()
 
-- end

return UGCGameState;
