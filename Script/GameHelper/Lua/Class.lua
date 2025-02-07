---@type table <string, Class>
local ClassRegister = {}

local function Index(mytable, key)
    local metatable = getmetatable(mytable)
    return metatable and metatable[key]
end

local function NewIndex(mytable, key, value)
    rawset(mytable, key, value)
end

---@param ClassObject Class
local function New(ClassObject)
    local Object = {}

    Object.SuperClass = ClassObject.SuperClass
    Object.ClassName = ClassObject.ClassName
    Object.BaseClass = ClassObject.BaseClass

    setmetatable(Object, Object.BaseClass)
    Object:Ctor()

    return Object
end

---@param ClassObject Class
local function GC(ClassObject)
    ClassObject:Dctor()
end

---@class Class:table
local Class = setmetatable({__call=New;__index=Index;__newindex=NewIndex;__gc=GC}, {__call=New;__index=Index;__newindex=NewIndex;__gc=GC})
Class.ClassName = "Class"
Class.BaseClass = Class
---@protected

function Class:Ctor()
end

function Class:Dctor()
end

---@endprotected

---@public

---@param ClassName string 子类类名
---@param SuperClassName string|nil 父类类名(若空则子类继承self，若不为空则继承该类)
function Class:Extend(ClassName, SuperClassName)
    if type(ClassName) ~= "string" then
        return
    end

    if ClassRegister[ClassName] then
        return ClassRegister[ClassName]
    end

    local SuperClass = (SuperClassName and ClassRegister[SuperClassName]) and ClassRegister[SuperClassName] or self

    ---@type Class
    local ClassInstance = {}
    ClassInstance.SuperClass = SuperClass
    ClassInstance.ClassName = ClassName
    ClassInstance.BaseClass = ClassInstance
    ClassInstance.__call = New
    ClassInstance.__index = Index
    ClassInstance.__newindex = NewIndex
    ClassInstance.__gc = GC
    setmetatable(ClassInstance, SuperClass)

    ClassRegister[ClassName] = ClassInstance

    return ClassInstance()
end

---@param ClassInstance Class
function Class:IsA(ClassInstance)
    if type(ClassInstance) ~= "table" then
        return false
    end

    local SuperClass = ClassInstance.BaseClass
    if SuperClass == nil or ClassRegister[SuperClass.SuperClass] == nil then
        return false
    end
    
    local BaseClass = self.BaseClass
    while BaseClass do
        if BaseClass == SuperClass then
            return true
        end
        BaseClass = BaseClass.SuperClass
    end

    return false
end

---@endpublic

return Class