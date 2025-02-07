---UI注册表
--[[
    绿洲需要新加的UI在此注册;
    注册方式:
    local UIRegistry = 
    {
        <UI别名> = {
            UIPath  = <资源路径>;
            Layer   = <UI层级:UIConfig.LayerType>;
        };
    }

    项目中打开和关闭UI的方式:
    EGUISystem:OpenUI(UI别名|UI路径);
    EGUISystem:CloseUI(UI别名|UI路径);
]]--

local UIConfig = require("Script.GameHelper.System.UISystem.UIConfig")

local UIRegistry = 
{
    ---@region 框架UI
    Operate = {
        UIPath  = "Asset/Blueprint/UI/WBP_Operate.WBP_Operate_C";
        Layer   = UIConfig.LayerType.UGC;
    };
    Menu = {
        UIPath  = "Asset/Blueprint/UI/WBP_Menu.WBP_Menu_C";
        Layer   = UIConfig.LayerType.UGCMore;
    };
    Tips = {
        UIPath  = "Asset/Blueprint/UI/WBP_Tips.WBP_Tips_C";
        Layer   = UIConfig.LayerType.CommonTips;
    };
    ---@endregion

    --@region 项目自定义UI
    CardAndGunMenu = {
        UIPath  = "Asset/Blueprint/UI/Menu/WBP_CardAndGunMenu.WBP_CardAndGunMenu_C";
        Layer   = UIConfig.LayerType.UGCMore;
    };
    ---@endregion
}

local function UGCMainUIInit()
    local UGCMainUI = UGCWidgetManagerSystem.GetMainUI()

    if UGCMainUI == nil then
        ugcprint("UIManager UGCMainUI is nil")
        return
    end

    local ShootingUI = UGCMainUI.ShootingUIPanel

    if ShootingUI == nil then
        ugcprint("UIManager ShootingUI is nil")
        return
    end
    
    -- ShootingUI.Customize_ThrowPlus:AddAdvancedCollapsedCount(1)
    -- ShootingUI.Customize_ThrowPlus:SetVisibility(ESlateVisibility.Collapsed)
    -- ShootingUI.SwitchWeaponSlot_Mode2.GridPanel_FireMode:AddAdvancedCollapsedCount(1)
    -- ShootingUI.SwitchWeaponSlot_Mode2:AddAdvancedCollapsedCount(1)                           -- 武器1
    -- ShootingUI.SwitchWeaponSlot_Mode2_C_0:AddAdvancedCollapsedCount(1)                       -- 武器2

    local MainControlBaseUI = UGCMainUI.MainControlBaseUI
    if MainControlBaseUI == nil then
        ugcprint("UIManager MainControlBaseUI is nil")
        return
    end
    
    -- MainControlBaseUI.Backpack_Border:AddAdvancedCollapsedCount(1)						    -- 背包
    -- MainControlBaseUI.Image_0:AddAdvancedCollapsedCount(1)								    -- 顶部三角标
    -- MainControlBaseUI.NavigatorPanel:AddAdvancedCollapsedCount(1)						    -- 顶部指南标
    -- MainControlBaseUI.CanvasPanel_MiniMapAndSetting:AddAdvancedCollapsedCount(1)			    -- 小地图
    -- MainControlBaseUI.CanvasPanelSurviveKill:AddAdvancedCollapsedCount(1)				    -- 存活人数

    return UIRegistry
end

return UGCMainUIInit()