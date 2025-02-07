---全局模块开关
--[[
    用于初始化时启动还是关闭对应模块;
    项目不需要的模块可以关闭模块;
    注释或者改为false，那么项目启动将不会导入对应模块;
]]--

local GlobalOnOff = 
{
    EGClass             = true;
    EGEventSystem       = true;
    EGUISystem          = true;
    EGAsyncLoadTool     = true;
    EGTableTool         = true;
    EGResourcesTool     = true;
    EGCachePoolTool     = true;
    EGVectorTool        = true;
    EGCommonLibrary     = true;
    EGServerSystem      = true;
    EGBuffSystem        = true;
}

return GlobalOnOff