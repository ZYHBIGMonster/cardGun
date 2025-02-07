---@class BuffBase:Class
local BuffBase = EGClass:Extend("BuffBase")

---函数顺序为buff整个生命周期的触发顺序

---@protected 继承时可重写，记得self.SuperClass.Ctor(self)
function BuffBase:Ctor()
    self.SuperClass.Ctor(self)
    self.bTick      = false --默认关闭tick,需要手动设置为true来开启
    self.Duration   = nil   --持续时间,若为nil则表示无限
    self.bActivate  = false --是否处于激活状态,不可手动修改值,在OnActivate时变成true,OnDeactivate时变成false
end

---@private 不要重写该函数，可使用前一时间点的Ctor()，或后一时间点的OnAttach()
---@param Owner AActor
---@param BuffID number
---@param Config table
function BuffBase:InitializeBuff(Owner, BuffID, Config)
    self.Owner = Owner
    self.BuffID = BuffID
    self.Config = Config
end

function BuffBase:OnAttach()
end

function BuffBase:OnBeginPlay()
end

function BuffBase:OnActivate()
end

function BuffBase:OnTick(DeltaTime)
end

function BuffBase:OnDeactivate()
end

function BuffBase:OnEndPlay()
end

function BuffBase:OnRemove()
end

---@param Causer AActor
---@param Victim AActor
---@return number
function BuffBase:OnOwnerAttack(Damage, Causer, Victim)
    return Damage
end

---@param Causer AActor
---@param Victim AActor
---@return number
function BuffBase:OnOwnerInjured(Damage, Causer, Victim)
    return Damage
end

return BuffBase