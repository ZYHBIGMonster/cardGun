-- 全局查找工具
---@class ResourcesTool
local ResourcesTool = {}

-- 加载蓝图Class
-- Path 示例 注意蓝图资源后缀需要加_C
-- "Asset/Blueprint/Items/Dice.Dice_C"
function ResourcesTool.LoadClass(Path)
    local FullPath = UGCMapInfoLib.GetRootLongPackagePath().. Path;
    return UE.LoadClass(FullPath);
end

-- 异步加载蓝图Class
-- Path 示例 注意蓝图资源后缀需要加_C
-- "Asset/Blueprint/Items/Dice.Dice_C"
function ResourcesTool.AsyncLoadClass(WorldContext, Path, CallBack)
    local FullPath = UGCMapInfoLib.GetRootLongPackagePath().. Path;
    CommonUtils:AsyncLoadClass(WorldContext, FullPath, 
        function (TargetClass)
            CallBack(TargetClass);
        end
    )
end

-- 加载非蓝图资源
-- Path 示例 注意蓝图资源后缀不需要加_C
-- "Asset/Blueprint/MeshA.MeshA"
function ResourcesTool.LoadObject(Path)
    local FullPath = UGCMapInfoLib.GetRootLongPackagePath().. Path;
    return UE.LoadObject(FullPath);
end

-- 异步加载非蓝图资源
-- Path 示例 注意蓝图资源后缀不需要加_C
-- "Asset/Blueprint/MeshA.MeshA"
function ResourcesTool.AsyncLoadObject(WorldContext, Path, CallBack)
    CommonUtils:AsyncLoadObject(WorldContext, Path, 
        function (TargetObject)
            CallBack(TargetObject);
        end
    )
end

-- 在场景中查找第一个指定类的Actor
function ResourcesTool.GetFirstActorOfClass(WorldContext,Path)
    local FindClass = ResourcesTool.LoadClass(Path);
    return GameplayStatics.GetFirstActorOfClass(WorldContext,FindClass);
end

-- 在场景中查找所有指定类的Actor
function ResourcesTool.GetAllActorsOfClass(WorldContext,Path)
    local FindClass = ResourcesTool.LoadClass(Path);
    return GameplayStatics.GetAllActorsOfClass(WorldContext,FindClass);
end

-- 在场景中查找第一个指定Tag的Actor
function ResourcesTool.GetFirstActorOfTag(WorldContext, Tag)
    local AllActors = GameplayStatics.GetAllActorsWithTag(WorldContext, Tag);
    if AllActors and #AllActors > 0 then
        return AllActors[1];
    end
end

-- 在场景中查找所有指定Tag的Actor
function ResourcesTool.GetAllActorsOfTag(WorldContext, Tag)
    return GameplayStatics.GetAllActorsWithTag(WorldContext, Tag);
end

return ResourcesTool;