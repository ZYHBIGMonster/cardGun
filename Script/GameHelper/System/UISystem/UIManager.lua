---UISystem专用，不建议其他地方使用
local UIManager = 
{
    PlayerController    = nil;
    UIClassRegistry     = {};
    UILayerStack        = {};
    UILayerTop          = {};
}

local UIConfig = require("Script.GameHelper.System.UISystem.UIConfig")

function UIManager:Init(PlayerController)
    self.PlayerController = PlayerController
end

local function ClearUIInfo(UI)
    local ClassRegistry = UI.ClassRegistry
    if UIManager.UILayerTop[ClassRegistry.Layer] == UI then
        UIManager.UILayerTop[ClassRegistry.Layer] = nil
        ClassRegistry.UIInstance = nil
    end
end

---@param UI NewUserWidget
local function OnCloseAnimationFinished(UI, bSuccess)
    if bSuccess then
        if UI.OnCloseAnimationFinished then
            UI:OnCloseAnimationFinished()
        end
        if UI.OnDeactive then
            UI:OnDeactive()
        end
        if UI.SetVisibility then
            UI:SetVisibility(ESlateVisibility.Collapsed)
        end

        ClearUIInfo(UI)
    end
end

function UIManager:OpenUI(UIName)
    local ClassRegistry = self.UIClassRegistry[UIName]
    if not ClassRegistry then
        print(string.format("[LuaException] UIManager:OpenUI No ClassRegistry[%s]", UIName))
        return
    end
    
    local Layer = ClassRegistry.Layer
    local UIStack = self.UILayerStack[Layer]

    if not UIStack then
        UIStack = stack.new()
        self.UILayerStack[Layer] = UIStack
    end

    ---@type NewUserWidget
    local CurOpenUI = UIManager.UILayerTop[Layer]
    stack.push(UIStack, CurOpenUI)

    ---@class NewUserWidget:UUserWidget
    local NewOpenUI = ClassRegistry.UIInstance
    if not NewOpenUI then
        NewOpenUI = UIManager:CreateUI(UIName, Layer)
        NewOpenUI.ClassRegistry = ClassRegistry
        ClassRegistry.UIInstance = NewOpenUI
        if NewOpenUI.CloseAnim then
            NewOpenUI:BindToAnimationFinished(NewOpenUI.CloseAnim, OnCloseAnimationFinished)
        end
        NewOpenUI:SetVisibility(ESlateVisibility.Collapsed)
    end
    stack.push(UIStack, NewOpenUI)

    if CurOpenUI then
        UIManager:CloseUI(CurOpenUI.ClassRegistry.UIPath)
    end
end

function UIManager:CloseUI(UIName)
    local ClassRegistry = self.UIClassRegistry[UIName]
    if not ClassRegistry then
        print(string.format("[LuaException] UIManager:OpenUI No ClassRegistry[%s]", UIName))
        return
    end

    if not ClassRegistry.UIInstance then
        print(string.format("[LuaException] UIManager:OpenUI No UIInstance[%s]", UIName))
        return
    end
    
    local Layer = ClassRegistry.Layer
    local CurOpenUI = self.UILayerTop[Layer]
    if CurOpenUI then
        if CurOpenUI.CloseAnim then
            CurOpenUI:PlayAnimation(CurOpenUI.CloseAnim)
        else
            OnCloseAnimationFinished(CurOpenUI, true)
        end
    else
        local UIStack = self.UILayerStack[Layer]
        local UI = stack.remove(UIStack, ClassRegistry.UIInstance)
        if UI then
            ClearUIInfo(UI)
        end
    end
end

---@param UIClass string|userdata
---@param Layer number
function UIManager:CreateUI(UIClass, Layer)
    if not UIClass then
        return nil
    end

    local ClassRegistry = nil

    if type(UIClass) == "string" then
        if self.UIClassRegistry[UIClass] then
            ClassRegistry = self.UIClassRegistry[UIClass]
            if ClassRegistry.UIClass then
                UIClass = ClassRegistry.UIClass
            else
                UIClass = EGResourcesTool.LoadClass(UIClass)
                ClassRegistry.UIClass = UIClass
            end
        end
    end

    if type(UIClass) ~= "userdata" then
        return nil
    end

    ---@type NewUserWidget
    local UI = UserWidget.NewWidgetObjectBP(self.PlayerController, UIClass)

    if UI ~= nil then
        UI:AddToViewport(Layer)
    else
        print(string.format("[LuaException] UIManager:CreateUI No Class[%s]", UE.GetFullName(UIClass)))
    end
    
    return UI
end

function UIManager:Tick(DeltaTime)
    for _Layer, _UIStack in pairs(self.UILayerStack) do
        if self.UILayerTop[_Layer] == nil and stack.size(_UIStack) > 0 then
            local UI = stack.pop(_UIStack)
            UI:SetVisibility(ESlateVisibility.SelfHitTestInvisible)
            if UI.OpenAnim then
                UI:PlayAnimation(UI.OpenAnim)
            end
            if UI.OnActive then
                UI:OnActive()
            end
        end
    end
end

return UIManager