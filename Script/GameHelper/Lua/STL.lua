---栈
---@class stack
stack = {}
stack.__index = stack

---TODO 暂时适配table，后续优化再改
---虽然目前是table，不过尽量还是使用stack.new()来创建stack
function stack.new()
    return {}
end

function stack.push(st, element)
    table.insert(st, element)
end

function stack.pop(st)
    return table.remove(st, #st)
end

function stack.top(st)
    return st[#st]
end

function stack.size(st)
    return #st
end

function stack.iter(st)
    local function iter(st, i)
        local v = st[i]
        if v then
            return i, v
        end
    end
    return iter, st, stack.size(st)
end

function stack.find(st, element)
    for i, v in stack.iter(st) do
        if v == element then
            return i
        end
    end
end

function stack.remove(st, element)
    local i = stack.find(st, element)
    if i then
        return table.remove(st, i)
    end
end

---队列
---@class queue
queue = {}
queue.__index = queue

---TODO 暂时适配table，后续优化再改
---虽然目前是table，不过尽量还是使用queue.new()来创建queue
function queue.new()
    return {}
end

function queue.push_back(que, element)
    table.insert(que, element)
end

function queue.push_front(que, element)
    table.insert(que, 1, element)
end

function queue.pop_back(que)
    return table.remove(que, #que)
end

function queue.pop_front(que)
    return table.remove(que, 1)
end

function queue.front(que)
    return que[1]
end

function queue.back(que)
    return que[#que]
end