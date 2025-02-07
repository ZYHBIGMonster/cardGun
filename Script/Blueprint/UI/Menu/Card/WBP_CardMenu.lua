---@class WBP_CardMenu_C:UUserWidget
---@field Button_Reset UButton
---@field HorizontalBox_Card UHorizontalBox
---@field REINST_WBP_Card_C_0 UWBP_Card_C
---@field WBP_Card UWBP_Card_C
---@field WBP_Card_1 UWBP_Card_C
---@field WBP_Card_2 UWBP_Card_C
---@field WBP_Card_3 UWBP_Card_C
---@field WBP_Card_4 UWBP_Card_C
--Edit Below--
local WBP_CardMenu = { bInitDoOnce = false } 

function WBP_CardMenu:Init()
    self.CardUIClass = EGResourcesTool.LoadClass("Asset/Blueprint/UI/Menu/Card/WBP_Card.WBP_Card_C")
    self:RefreshCards(GameStatePtr.RoundCards)
	self.Button_Reset.OnClicked:Add(self.ResetCardVote, self)
    EGEventSystem:AddListenerByEventType(EGEventType.OnRoundCardsChanged, self)
end

function WBP_CardMenu:OnRoundCardsChanged(Cards)
    local MaxCount = math.max(self.HorizontalBox_Card:GetChildrenCount(), #Cards)
    for i = MaxCount, 1, -1 do
        if Cards[i] then
            local UI = self.HorizontalBox_Card:GetChildAt(i)
            if not UI then
                UI = EGUISystem:CreateUI(self.CardUIClass)
                self.HorizontalBox_Card:AddChild(UI)
            end
            UI:RefreshCard(Cards[i])
        else
        end
    end
end

function WBP_CardMenu:ResetCardVote()
	EGServerSystem.SendClientRPC("ResetCardVote")
end

--[==[ Construct
function WBP_CardMenu:Construct()
	
end
-- Construct ]==]

-- function WBP_CardMenu:Tick(MyGeometry, InDeltaTime)

-- end

-- function WBP_CardMenu:Destruct()

-- end

return WBP_CardMenu