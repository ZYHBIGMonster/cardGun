GameHelper = GameHelper or {
    global_on_off   = {};
    RequirePathMap  = {};
}

local function GameInit()
    --重置随机种子
    math.randomseed(tostring(os.time()):reverse():sub(1, 7))
end

local function OnOffRequire(GlobalName, FilePath)
    if not GameHelper.global_on_off[GlobalName] then
        GameHelper.RequirePathMap[GlobalName] = FilePath
        return nil
    end

    --尽量只设置当前全局环境
    local GlobalObject = require(FilePath)
    _ENV[GlobalName] = GlobalObject
    print(string.format("GameHelper Require %s %s", GlobalName, GlobalObject and "Successfully" or "Fail"))

    return GlobalObject
end

local function Init()
    print("GameHelper Init")
    print("LUA_VERSION:" .. (_VERSION or "nil"))

    GameHelper.global_on_off = require("Script.Config.GlobalOnOff")

    ---自定义标准模板库
    require("Script.GameHelper.Lua.STL")
    ---全局API
    require("Script.GameHelper.Lua.GlobalAPI")

    ---Lua类
    ---@type Class
    EGClass = OnOffRequire("EGClass", "Script.GameHelper.Lua.Class")
    ---Vector工具
    ---@type VectorTool
    EGVectorTool = OnOffRequire("EGVectorTool", "Script.GameHelper.Tool.VectorTool")
    ---Vector工具
    ---@type CommonLibrary
    EGCommonLibrary = OnOffRequire("EGCommonLibrary", "Script.GameHelper.Library.CommonLibrary")
    ---Table工具
    ---@type TableTool
    EGTableTool = OnOffRequire("EGTableTool", "Script.GameHelper.Tool.TableTool")
    ---异步加载工具
    ---@type AsyncLoadTool
    EGAsyncLoadTool = OnOffRequire("EGAsyncLoadTool", "Script.GameHelper.Tool.AsyncLoadTool")
    ---资源工具
    ---@type ResourcesTool
    EGResourcesTool = OnOffRequire("EGResourcesTool", "Script.GameHelper.Tool.ResourcesTool")
    ---缓存池工具
    ---@type CachePoolTool
    EGCachePoolTool = OnOffRequire("EGCachePoolTool", "Script.GameHelper.Tool.CachePoolTool")
    ---事件系统
    ---@type EventSystem
    EGEventSystem = OnOffRequire("EGEventSystem", "Script.GameHelper.System.EventSystem.EventSystem")
    ---服务器系统
    ---@type ServerSystem
    EGServerSystem = OnOffRequire("EGServerSystem", "Script.GameHelper.System.ServerSystem.ServerSystem")
    ---Buff系统
    ---@type BuffSystem
    EGBuffSystem = OnOffRequire("EGBuffSystem", "Script.GameHelper.System.BuffSystem.BuffSystem")
    ---UI系统
    ---@type UISystem
    EGUISystem = OnOffRequire("EGUISystem", "Script.GameHelper.System.UISystem.UISystem")
    ---等所有东西准备再开始
    GameInit()

    return GameHelper
end

---@param key string
---@return bool
function GameHelper:OpenRequireFile(key)
    if type(key) ~= "string" or not self.RequirePathMap[key] then
        return nil
    end

    local GlobalObject = _ENV[key]

    if not self.global_on_off[key] then
        if GlobalObject then
            print(string.format("GameHelper:OpenRequireFile Change GlobalObject[%s]", key))
        end
        self.global_on_off[key] = true
        GlobalObject = OnOffRequire(key, self.RequirePathMap[key])
    end

    return GlobalObject
end

return Init()