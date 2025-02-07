---@class EventSystem
local EventSystem = 
{
    Events = {};
};

---事件类型
---@type EventType
EGEventType = EGEventType or require("Script.GameHelper.System.EventSystem.EventType")

--添加监听
---@param EventType EventType
---@param Func function
---@param Object table
function EventSystem:AddListener(EventType, Func, Object)
    if EventType == nil or Func == nil then
        print("Error: EventSystem:AddListener EventType or Func is nil!");
        return;
    end

    local FuncData = {};
    FuncData.Object = Object;
    FuncData.Func = Func;

    if self.Events[EventType]==nil then
        local NewEventFuncs={};
        table.insert(NewEventFuncs ,FuncData);
        self.Events[EventType] = NewEventFuncs;
        print_dev(string.format("EventSystem:AddListener EventType[%s], Func[%s]", tostring(EventType), tostring(Func)));
    else
        table.insert(self.Events[EventType], FuncData)
        print_dev(string.format("EventSystem:AddListener EventType[%s], Func[%s]", tostring(EventType), tostring(Func)));
    end
end

---@param EventType EventType
---@param Object table
function EventSystem:AddListenerByEventType(EventType, Object)
    if EventType == nil or Object == nil then
        print("Error: EventSystem:AddListenerByEventType EventType or Object is nil!");
        return;
    end
    self:AddListener(EventType, Object[EventType], Object)
end

--移除监听
---@param EventType EventType
---@param Func function
---@param Object table
function EventSystem:RemoveListener(EventType, Func, Object)
    if EventType == nil or Func == nil then
        print("Error: EventSystem:AddListener EventType or Func is nil!");
        return;
    end
    local EventFuncs = self.Events[EventType];
    if EventFuncs ~= nil then
        for i, FuncData in pairs(EventFuncs) do
            if FuncData.Func == Func and FuncData.Object == Object then
                EventFuncs[i] = nil;
            end
        end
    end
end

---@param EventType EventType
---@param Object table
function EventSystem:RemoveListenerByEventType(EventType, Object)
    if EventType == nil or Object == nil then
        print("Error: EventSystem:RemoveListenerByEventType EventType or Object is nil!");
        return;
    end
    self:RemoveListener(EventType, Object[EventType], Object)
end

function EventSystem:RemoveAll()
    for k,EventFuncs in pairs(self.Events) do
        for i, FuncData in pairs(EventFuncs) do
            FuncData.Func = nil
            FuncData.Object = nil
        end
    end

    self.Events = {}
end

--派发事件
---@param EventType EventType
function EventSystem:SendEvent(EventType, ...)
    print_dev(string.format("EventSystem:SendEvent self[%s], EventType[%s]", tostring(self), tostring(EventType)));
    if EventType ~= nil then
        local EventFuncs = self.Events[EventType];
        if EventFuncs ~= nil then
            for i, FuncData in pairs(EventFuncs) do
                if FuncData.Object ~= nil then
                    FuncData.Func(FuncData.Object, ...);
                else
                    FuncData.Func(...);
                end
            end
        else
            print_dev(string.format("EventSystem:SendEvent EventFuncs[%s] is nil!", tostring(EventType)));
        end
    end
end

return EventSystem