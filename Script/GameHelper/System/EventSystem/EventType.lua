---事件类型
---@class EventType
local EventType = {};

---@region 事件登记(记录框架内事件)

EventType.ReceiveTick       = "ReceiveTick" --tick事件
EventType.ReceiveClientReq  = "ReceiveClientReq" --接收客户端请求

---endregion

---自动生成事件类型，懒人做法，不推荐，有良心的推荐在事件登记记录一下
local function Index(mytable, key)
    rawset(mytable, key, key)
    return mytable[key]
end

return setmetatable(EventType, {__index=Index;})