---@class UISystem
local UISystem = {}

local UIConfig = require("Script.GameHelper.System.UISystem.UIConfig")
local UIManager = require("Script.GameHelper.System.UISystem.UIManager")

local function Init()
    return UISystem
end

function UISystem:Startup(PlayerController)
    self.PlayerController = PlayerController
    UIManager:Init(PlayerController)
    self:RegisterStaticUI()
    EGEventSystem:AddListenerByEventType(EGEventType.ReceiveTick, self)
end

function UISystem:ReceiveTick(DeltaTime)
    UIManager:Tick(DeltaTime)
end

function UISystem:RegisterStaticUI()
    self.UIRegistry = require("Script.Config.UIRegistry")
    if not self.UIRegistry then
        print("[LuaException] UISystem:RegisterStaticUI No UIRegistry")
        return
    end

    for _UIName, _UIRegistry in pairs(self.UIRegistry) do
        self:RegisterUI(_UIRegistry)
    end

    self:OpenUI("Operate")
    self:OpenUI("Menu")
    self:OpenUI("Tips")
end

function UISystem:RegisterUI(UIRegistry)
    local ClassRegistry         = {}
    ClassRegistry.UIPath        = UIRegistry.UIPath
    ClassRegistry.Layer         = UIRegistry.Layer

    UIManager.UIClassRegistry[UIRegistry.UIPath] = ClassRegistry
end

---@param UIName string|path
function UISystem:OpenUI(UIName)
    local UIPath = self.UIRegistry[UIName] and self.UIRegistry[UIName].UIPath or UIName
    UIManager:OpenUI(UIPath)
end

---@param UIName string|path
function UISystem:CloseUI(UIName)
    local UIPath = self.UIRegistry[UIName] and self.UIRegistry[UIName].UIPath or UIName
    UIManager:CloseUI(UIPath)
end

function UISystem:CreateUI(UIClass)
    UIManager:CreateUI(UIClass)
end

return Init()