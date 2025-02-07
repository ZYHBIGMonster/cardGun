---@class BuffSystem
local BuffSystem = {}

local function Init()
    ---@type BuffConfig
    BuffSystem.BuffConfig = require("Script.Config.BuffConfig")
    BuffSystem.BuffRegistry = {}
    BuffSystem.OwnerBuffs = {}
    EGEventSystem:AddListenerByEventType(EGEventType.ReceiveTick, BuffSystem)
    return BuffSystem
end

---获取Buff
---@param Owner AActor
function BuffSystem:GetAllBuff(BuffID, Owner)
    return self.OwnerBuffs[Owner] or {}
end

---@return BuffConfig
function BuffSystem:GetBuffConfig()
    return self.BuffConfig
end

---添加Buff
---@param Owner AActor
---@param Config table 配置表
---@return BuffBase
function BuffSystem:AddBuff(BuffID, Owner, Config)
    ugcprint_f("BuffSystem:AddBuff BuffID[%s] Owner[%s]", BuffID, UE.GetName(Owner))

    local BuffClass = self.BuffRegistry[BuffID]

    if not BuffClass then
        if self.BuffConfig.BuffRegistry[BuffID] then
            BuffClass = require(self.BuffConfig.BuffRegistry[BuffID])
            self.BuffRegistry[BuffID] = BuffClass
        else
            print_f("BuffSystem:AddBuff No BuffID[%s]", BuffID)
            return
        end
    end

    ---@type BuffBase
    local Buff = BuffClass()
    Buff:InitializeBuff(Owner, BuffID, Config)
    Buff:OnAttach()
    Buff:OnBeginPlay()
    Buff.bActivate = true
    Buff:OnActivate()

    Owner = Owner or self
    local Buffs = self.OwnerBuffs[Owner] or {}
    Buffs[BuffID] = Buff
    self.OwnerBuffs[Owner] = Buffs

    return Buff
end

---移除Buff
---@param Owner AActor
function BuffSystem:RemoveBuff(BuffID, Owner)
    ugcprint_f("BuffSystem:RemoveBuff BuffID[%s] Owner[%s]", BuffID, UE.GetName(Owner))
    
    Owner = Owner or self
    local Buffs = self.OwnerBuffs[Owner]
    local Buff = Buffs[BuffID]

    if Buff then
        Buff:OnDeactivate()
        Buff:OnEndPlay()
        Buff:OnRemove()
        Buffs[BuffID] = nil
    end
end

---暂停Buff
---@param Owner AActor
function BuffSystem:DeactivateBuff(BuffID, Owner)
    ugcprint_f("BuffSystem:DeactivateBuff BuffID[%s] Owner[%s]", BuffID, UE.GetName(Owner))
    
    Owner = Owner or self
    local Buffs = self.OwnerBuffs[Owner]
    local Buff = Buffs[BuffID]

    if Buff.bActivate == true then
        Buff.bActivate = false
        Buff:OnDeactivate()
    end
end

---激活Buff
---@param Owner AActor
function BuffSystem:ActivateBuff(BuffID, Owner)
    ugcprint_f("BuffSystem:ActivateBuff BuffID[%s] Owner[%s]", BuffID, UE.GetName(Owner))
    
    Owner = Owner or self
    local Buffs = self.OwnerBuffs[Owner]
    local Buff = Buffs[BuffID]

    if Buff.bActivate == false then
        Buff.bActivate = true
        Buff:OnActivate()
    end
end

function BuffSystem:ReceiveTick(DeltaTime)
    for _Owner, _Buffs in pairs(self.OwnerBuffs) do
        if _Owner == self or IsValid(_Owner) then
            for _BuffID, _Buff in pairs(_Buffs) do
                if _Buff.bTick then
                    _Buff:OnTick(DeltaTime)
                end
                
                if _Buff.Duration then
                    if _Buff.Duration > DeltaTime then
                        _Buff.Duration = _Buff.Duration - DeltaTime
                    else
                        BuffSystem:RemoveBuff(_BuffID, _Owner)
                    end
                end
            end
        else
            for _BuffID, _Buff in pairs(_Buffs) do
                BuffSystem:RemoveBuff(_BuffID, _Owner)
            end
            self.OwnerBuffs[_Owner] = nil
        end
    end
end

---@param Damage number
---@param Causer APawn
---@param Victim APawn
function BuffSystem:HandleDamageEvent(Damage, Causer, Victim)
    local OwnerBuffs = self.OwnerBuffs

    if OwnerBuffs[self] then
        ---@param _Buff BuffBase
        for _BuffID, _Buff in pairs(OwnerBuffs[self]) do
            Damage = _Buff:OnOwnerAttack(Damage, Causer, Victim)
            Damage = _Buff:OnOwnerInjured(Damage, Causer, Victim)
        end
    end

    if OwnerBuffs[Causer] then
        ---@param _Buff BuffBase
        for _BuffID, _Buff in pairs(OwnerBuffs[Causer]) do
            Damage = _Buff:OnOwnerAttack(Damage, Causer, Victim)
        end
    end
    
    local Controller = Causer.Controller
    if Controller and OwnerBuffs[Controller] then
        ---@param _Buff BuffBase
        for _BuffID, _Buff in pairs(OwnerBuffs[Controller]) do
            Damage = _Buff:OnOwnerAttack(Damage, Causer, Victim)
        end
    end

    if OwnerBuffs[Victim] then
        ---@param _Buff BuffBase
        for _BuffID, _Buff in pairs(OwnerBuffs[Victim]) do
            Damage = _Buff:OnOwnerAttack(Damage, Causer, Victim)
        end
    end
    
    Controller = Victim.Controller
    if Controller and OwnerBuffs[Controller] then
        ---@param _Buff BuffBase
        for _BuffID, _Buff in pairs(OwnerBuffs[Controller]) do
            Damage = _Buff:OnOwnerAttack(Damage, Causer, Victim)
        end
    end

    return Damage
end

return 