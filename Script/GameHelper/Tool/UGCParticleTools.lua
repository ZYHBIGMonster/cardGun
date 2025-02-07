-- UGCParticleTools = UGCParticleTools or {}

-- local Path = function(Str)
--     return UGCMapInfoLib.GetRootLongPackagePath()..Str
-- end

-- UGCParticleTools.List = 
-- {
--     RedLevelUpMax        = 1;
--     WolfLevelUpMax       = 2;
--     RedLevelUp           = 3;
--     WolfLevelUp          = 4;
--     CakeWallHitGround    = 5;
--     Teleporter           = 6;
--     CakeFroth            = 7;
--     CakePointUIAnimation = 8;
--     WolfVip              = 9;
--     RedVip               = 10;
-- }

-- UGCParticleTools.ID2List = 
-- {
--     [UGCParticleTools.List.RedLevelUpMax]        = Path("Asset/Effect/ParticleSystems/P_Hunter_Change_01_01.P_Hunter_Change_01_01");
--     [UGCParticleTools.List.WolfLevelUpMax]       = Path("Asset/Effect/ParticleSystems/P_Woif_change_01_01.P_Woif_change_01_01");
--     [UGCParticleTools.List.RedLevelUp]           = Path("Asset/Effect/ParticleSystems/P_LevelUp_2.P_LevelUp_2");
--     [UGCParticleTools.List.WolfLevelUp]          = Path("Asset/Effect/ParticleSystems/P_LevelUp_1.P_LevelUp_1");
--     [UGCParticleTools.List.CakeWallHitGround]    = '/Game/Arts_Effect/ParticleSystems/FX_PVE/P_DrG_HitGround.P_DrG_HitGround';
--     [UGCParticleTools.List.Teleporter]           = Path('Asset/Effect/ParticleSystems/P_ZhuanSong_01_001.P_ZhuanSong_01_001');
--     [UGCParticleTools.List.CakeFroth]            = Path("Asset/Effect/ParticleSystems/P_Cake_FeiJian_01_001.P_Cake_FeiJian_01_001");
--     [UGCParticleTools.List.CakePointUIAnimation] = Path("Asset/Effect/ParticleSystems/P_Cake_Add1_01_001.P_Cake_Add1_01_001");
--     [UGCParticleTools.List.WolfVip]              = Path("Asset/Effect/ParticleSystems/P_Mace_01_001.P_Mace_01_001");
--     [UGCParticleTools.List.RedVip]               = Path("Asset/Effect/ParticleSystems/P_Fork_01_001.P_Fork_01_001");
-- }

-- function UGCParticleTools:PreLoad()
--     print_dev("UGCParticleTools:PreLoad")
--     for k,ParticleSystemPath in pairs(self.ID2List) do
--         self:Load(ParticleSystemPath)
--     end
-- end

-- function UGCParticleTools:Load(ParticleSystemPath)
--     UE.LoadObject(ParticleSystemPath)
-- end

-- return UGCParticleTools