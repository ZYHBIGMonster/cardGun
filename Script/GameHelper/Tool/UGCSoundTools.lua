-- require("Script.GameHelper.Tool.VectorTool")
-- UGCSoundTools = UGCSoundTools or {}

-- --指定玩家客户端播放2D音效
-- function UGCSoundTools:ServerPlaySound2D(PlayerKey, SoundPath)
--     if PlayerKey == nil then
--         return
--     end

--     if LittleRedAudioConfig.ID2Path[SoundPath] == nil or LittleRedAudioConfig.ID2Path[SoundPath] == "" then
--         return
--     end

--     print_dev("UGCSoundTools:ServerPlaySound2D:"..PlayerKey.." SoundPath:"..SoundPath)

--     local PlayerController = UGCGameSystem.GetPlayerControllerByPlayerKey(PlayerKey)
--     if PlayerController == nil then
--         print("UGCSoundTools:ServerPlaySound2D PlayerController is nil")
--         return
--     end

--     if PlayerController:HasAuthority() == false then
--         return
--     end

--     UnrealNetwork.CallUnrealRPC_Unreliable(PlayerController, PlayerController, "SC_P_Sound2D", SoundPath);
-- end

-- --全体玩家客户端播放2D音效
-- function UGCSoundTools:MultiCastPlaySound2D(SoundPath)
--     if LittleRedAudioConfig.ID2Path[SoundPath] == nil or LittleRedAudioConfig.ID2Path[SoundPath] == "" then
--         return
--     end

--     if UGCGameSystem.GameState:HasAuthority() == false then
--         return
--     end

--     UnrealNetwork.CallUnrealRPC_Multicast_Unreliable(UGCGameSystem.GameState, "MC_PS2D", SoundPath);
-- end

-- --指定玩家客户端播放3D音效
-- function UGCSoundTools:ServerPlaySound3D(PlayerKey, Location, SoundPath)
--     if LittleRedAudioConfig.ID2Path[SoundPath] == nil or LittleRedAudioConfig.ID2Path[SoundPath] == "" then
--         return
--     end

--     print_dev("UGCSoundTools:ServerPlaySound3D:"..PlayerKey.." SoundPath:"..SoundPath)

--     local PlayerController = UGCGameSystem.GetPlayerControllerByPlayerKey(PlayerKey)
--     if PlayerController == nil then
--         print("UGCSoundTools:ServerPlaySound3D PlayerController is nil")
--         return
--     end

--     if PlayerController:HasAuthority() == false then
--         return
--     end

--     Location = VectorHelper.ToLuaTable(Location)
--     UnrealNetwork.CallUnrealRPC_Unreliable(PlayerController, PlayerController, "SC_P_Sound3D", Location, SoundPath);
-- end

-- --全体玩家客户端播放3D音效
-- function UGCSoundTools:MultiCastPlaySound3D(Location, SoundPath)
--     if LittleRedAudioConfig.ID2Path[SoundPath] == nil or LittleRedAudioConfig.ID2Path[SoundPath] == "" then
--         return
--     end

--     print_dev("UGCSoundTools:MultiCastPlaySound3D:"..SoundPath)

--     if UGCGameSystem.GameState:HasAuthority() == false then
--         return
--     end

--     Location = VectorHelper.ToLuaTable(Location)
--     UnrealNetwork.CallUnrealRPC_Multicast_Unreliable(UGCGameSystem.GameState, "MC_PS3D", Location, SoundPath);
-- end

-- function UGCSoundTools:ServerStopSound(PlayerKey, SoundPath)
--     if LittleRedAudioConfig.ID2Path[SoundPath] == nil or LittleRedAudioConfig.ID2Path[SoundPath] == "" then
--         return
--     end

--     print_dev("UGCSoundTools:ServerStopSound:"..PlayerKey.." SoundPath:"..SoundPath)

--     local PlayerController = UGCGameSystem.GetPlayerControllerByPlayerKey(PlayerKey)
--     if PlayerController == nil then
--         print("UGCSoundTools:ServerPlaySound3D PlayerController is nil")
--         return
--     end

--     if PlayerController:HasAuthority() == false then
--         return
--     end

--     UnrealNetwork.CallUnrealRPC_Unreliable(PlayerController, PlayerController, "SC_S_Sound", SoundPath);
-- end

-- function UGCSoundTools:MultiCastStopSound(SoundPath)
--     if LittleRedAudioConfig.ID2Path[SoundPath] == nil or LittleRedAudioConfig.ID2Path[SoundPath] == "" then
--         return
--     end

--     print_dev("UGCSoundTools:MultiCastStopSound:"..SoundPath)

--     if UGCGameSystem.GameState:HasAuthority() == false then
--         return
--     end

--     UnrealNetwork.CallUnrealRPC_Multicast_Unreliable(UGCGameSystem.GameState, "MC_SS3D", SoundPath);
-- end

-- -------------------------------------客户端逻辑部分-------------------------------------

-- function UGCSoundTools:ClientPlaySound2D(SoundPath, Actor)
--     if UGCGameSystem.GameState == nil then
--         return
--     end

--     if LittleRedAudioConfig.ID2Path[SoundPath] == nil or LittleRedAudioConfig.ID2Path[SoundPath] == "" then
--         return
--     end

--     local PlayerController = GameplayStatics.GetPlayerController(UGCGameSystem.GameState, 0)
--     if PlayerController == nil then return false end
--     if PlayerController.SoundDict == nil then PlayerController.SoundDict = {} end

--     --随机音效处理，一个主ID，对应多个子id
--     --如果主ID对应配置的是表，则随机找子id再找路径
--     local RealPath = LittleRedAudioConfig.ID2Path[SoundPath]
--     if type(RealPath) == "table" then
--         local RandomIndex = math.random(1, #RealPath)
--         local RandomId = RealPath[RandomIndex]
--         RealPath = LittleRedAudioConfig.ID2Path[RandomId]
--         SoundPath = RandomId
--     end

--     local AKEvent = PlayerController.SoundDict[SoundPath]
--     if AKEvent == nil then
--         local RealPath = LittleRedAudioConfig.ID2Path[SoundPath]
--         AKEvent = UE.LoadObject(RealPath)
--         PlayerController.SoundDict[SoundPath] = AKEvent
--     end

--     if AKEvent then
--         if Actor == nil then
--             local AKEventID = AkGameplayStatics.PostEventAtLocation(AKEvent, Vector.New(0, 0, 0), Rotator.New(0, 0, 0), "", GameFrontendHUD)
--             UGCGameSystem.GameState.PlayingSound[SoundPath] = AKEventID
--         else
--             local AKEventID = AkGameplayStatics.PostEvent(AKEvent, Actor, true)
--             UGCGameSystem.GameState.PlayingSound[SoundPath] = AKEventID
--         end
--     end
-- end

-- function UGCSoundTools:ClientPlaySound3D(Location, SoundPath)
--     if UGCGameSystem.GameState == nil then
--         return
--     end

--     if LittleRedAudioConfig.ID2Path[SoundPath] == nil or LittleRedAudioConfig.ID2Path[SoundPath] == "" then
--         return
--     end

--     local PlayerController = GameplayStatics.GetPlayerController(UGCGameSystem.GameState, 0)
--     if PlayerController == nil then return false end
--     if PlayerController.SoundDict == nil then PlayerController.SoundDict = {} end
    
--     --随机音效处理，一个主ID，对应多个子id
--     --如果主ID对应配置的是表，则随机找子id再找路径
--     local RealPath = LittleRedAudioConfig.ID2Path[SoundPath]
--     if type(RealPath) == "table" then
--         local RandomIndex = math.random(1, #RealPath)
--         local RandomId = RealPath[RandomIndex]
--         RealPath = LittleRedAudioConfig.ID2Path[RandomId]
--         SoundPath = RandomId
--     end

--     local AKEvent = PlayerController.SoundDict[SoundPath]
--     if AKEvent == nil then
--         local RealPath = LittleRedAudioConfig.ID2Path[SoundPath]
--         AKEvent = UE.LoadObject(RealPath)
--         PlayerController.SoundDict[SoundPath] = AKEvent
--     end
    
--     if AKEvent then
--         local AKEventID = AkGameplayStatics.PostEventAtLocation(AKEvent, Location, Rotator.New(0, 0, 0), "", GameFrontendHUD)
--         UGCGameSystem.GameState.PlayingSound[SoundPath] = AKEventID
--     end
-- end

-- --客户端通知DS需要广播音效
-- function UGCSoundTools:ClientMultiCastSound2D(SoundPath)
--     if UGCGameSystem.GameState == nil then
--         return
--     end

--     if LittleRedAudioConfig.ID2Path[SoundPath] == nil or LittleRedAudioConfig.ID2Path[SoundPath] == "" then
--         return
--     end

--     local PlayerController = GameplayStatics.GetPlayerController(UGCGameSystem.GameState, 0)
--     if PlayerController ~= nil then
--         UnrealNetwork.CallUnrealRPC_Unreliable(PlayerController, PlayerController, "ClientMultiCastSound2D", SoundPath);
--     end
-- end

-- function UGCSoundTools:ClientStopSound(SoundPath)
--     if UGCGameSystem.GameState == nil then
--         return
--     end
    
--     local AKEventID = UGCGameSystem.GameState.PlayingSound[SoundPath]
--     if AKEventID ~= nil then
--         AkGameplayStatics.StopAkEventByID(AKEventID)
--     end
-- end

-- function UGCSoundTools:ClientStopAllSound()
--     print_dev("UGCSoundTools:ClientStopAllSound")
--     if UGCGameSystem.GameState ~= nil then
--         for k,AKEventID in pairs(UGCGameSystem.GameState.PlayingSound) do
--             AkGameplayStatics.StopAkEventByID(AKEventID)
--         end
--     end
-- end

-- return UGCSoundTools