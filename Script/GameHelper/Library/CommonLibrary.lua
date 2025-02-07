---@class CommonLibrary
local CommonLibrary = {}

--[[----------------------------------------------- 常量（不能赋值给可以修改的变量，会导致库内的参数一起被修改） --------------------------------------------]]--
---颜色
CommonLibrary.Color_Red      = {R=1;G=0;B=0;A=1}
CommonLibrary.Color_Green    = {R=0;G=1;B=0;A=1}
CommonLibrary.Color_Blue     = {R=0;G=0;B=1;A=1}

---变换
CommonLibrary.ZeroVec        = {X=0;Y=0;Z=0;}
CommonLibrary.ZeroRot        = {Roll=0;Pitch=0;Yaw=0;}
CommonLibrary.OneScale       = {X=1;Y=1;Z=1;}

---中文数字
CommonLibrary.ChineseNumber  = {[0]="零";[1]="一";[2]="二";[3]="三";[4]="四";[5]="五";[6]="六";[7]="七";[8]="八";[9]="九";[10]="十";}

---数字对应字母
CommonLibrary.LetterMap = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}


--[[---------------------------------------------------------------------- API ------------------------------------------------------------------------]]--

--打印Vector
function CommonLibrary.PrintVec(Prefix, Vec)
    print(string.format(Prefix .. " X[%s], Y[%s], Z[%s]", Vec.X, Vec.Y, Vec.Z))
end

---传送人物
---@param Pawn BP_UGCPlayerPawn_C
function CommonLibrary.TeleportToPoint(Pawn, Loc, Rot)
    local OldbShouldDumpCallstackWhenMovingfast = Pawn.bShouldDumpCallstackWhenMovingfast

    Pawn.bShouldDumpCallstackWhenMovingfast = false
    Pawn:SetClientLocationOrRotation(Loc, Rot or CommonLibrary.ZeroRot, true, false)
    Pawn.bShouldDumpCallstackWhenMovingfast = OldbShouldDumpCallstackWhenMovingfast
end

---生成Actor(总是生成)
function CommonLibrary.SpawnActorAlways(WorldContextObject, ActorClass, Location, Rotation, Scale3D, Owner)
    return ScriptGameplayStatics.SpawnActor(WorldContextObject, ActorClass, Location or CommonLibrary.ZeroVec, Rotation or CommonLibrary.ZeroRot, Scale3D or CommonLibrary.OneScale, Owner, ESpawnActorCollisionHandlingMethod.TryToFindASuitablePlaceButAlwaysSpawn)
end

--开启tick
---@param Actor AActor
function CommonLibrary.OpenTick(Actor, bOpen)
    Actor.PrimaryActorTick.bCanEverTick = bOpen
    Actor.bAllowBPReceiveTickEvent = bOpen
    Actor.bAllowReceiveTickEventOnDedicatedServer = bOpen
end

return CommonLibrary