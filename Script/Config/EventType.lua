---事件登记处
--[[
    可以登记项目事件类型在此处，方便查询
    1.登记方式:
    EventType.类型名 = string
    2.常用引用方式:
    EGEventType.类型名
    3.另一引用方式:
    require出EventType，再EventType.类型名
]]
---@class EventType
local EventType = require("Script.GameHelper.System.EventSystem.EventType")



return EventType