---@class WBP_CardAndGunMenu_C:UUserWidget
---@field Image_0 UImage
---@field REINST_WBP_CardMenu_C_0 UWBP_CardMenu_C
---@field WBP_CardMenu UWBP_CardMenu_C
---@field WidgetSwitcher_0 UWidgetSwitcher
--Edit Below--
local WBP_CardAndGunMenu = { bInitDoOnce = false } 

function WBP_CardAndGunMenu:Construct()
	self.WBP_CardMenu:Init()
end

-- function WBP_CardAndGunMenu:Tick(MyGeometry, InDeltaTime)

-- end

-- function WBP_CardAndGunMenu:Destruct()

-- end

return WBP_CardAndGunMenu