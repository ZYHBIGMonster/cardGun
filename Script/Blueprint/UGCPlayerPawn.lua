---@class UGCPlayerPawn_C:BP_UGCPlayerPawn_C
--Edit Below--
---@type UGCPlayerPawn_C
local UGCPlayerPawn = {}

function UGCPlayerPawn:GetReplicatedProperties()
    return
end

function UGCPlayerPawn:ReceiveBeginPlay()
    UGCPlayerPawn.SuperClass.ReceiveBeginPlay(self)
    self.bVaultIsOpen = true
end

function UGCPlayerPawn:ReceiveTick(DeltaTime)
    UGCPlayerPawn.SuperClass.ReceiveTick(self, DeltaTime)
end

---该接口跑在护甲头盔伤害之前
function UGCPlayerPawn:BP_CharacterModifyDamage(OriginalDamage, DamageEvent, EventInstigator, DamageCauser)
    ugcprint_f("UGCPlayerPawn:UGC_TakeDamageOverrideEvent OriginalDamage[%s]", OriginalDamage)
    local Damage = EGBuffSystem:HandleDamageEvent(OriginalDamage, DamageCauser, self)
    ugcprint_f("UGCPlayerPawn:UGC_TakeDamageOverrideEvent Damage[%s]", Damage)
    return Damage
end

---该接口跑在护甲头盔伤害之后
function UGCPlayerPawn:UGC_TakeDamageOverrideEvent(OriginalDamage, DamageType, EventInstigator, DamageCauser, FHitResultHit)
    return OriginalDamage
end

---死亡盒子
---@param EventInsigater AController
function UGCPlayerPawn:IsSkipSpawnDeadTombBox(EventInsigater)
    return true --不生成盒子
end

--[[
function UGCPlayerPawn:ReceiveEndPlay()
    UGCPlayerPawn.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function UGCPlayerPawn:GetAvailableServerRPCs()
    return
end
--]]

return UGCPlayerPawn