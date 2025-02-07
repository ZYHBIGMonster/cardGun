---@class ServerSystem
local ServerSystem = {}

ServerSystem.ReceiveClientRPCFuncName = "ReceiveClientRPC"
---@type ServerConfig
ServerSystem.ServerConfig = require("Script.Config.ServerConfig")
ServerSystem.ReqCMD = ServerSystem.ServerConfig.ReqCMD

---客户端单播RPC
---@param ReqCMD string 可以是ReqCMD，也可以是PlayerController的函数名
function ServerSystem.SendClientRPC(ReqCMD, ...)
    UnrealNetwork.CallUnrealRPC(PlayerControllerPtr, PlayerControllerPtr, ServerSystem.ReceiveClientRPCFuncName, ReqCMD, ...)
end

function ServerSystem.ReceiveClientRPC(ReqCMD, ...)
    print(string.format("ServerSystem.ReceiveClientRPC ReqCMD[%s]", ReqCMD))
    EGEventSystem:SendEvent(EGEventType.ReceiveClientReq .. ReqCMD, ...)
end

---服务端单播RPC
---@param PlayerController BP_UGCPlayerController_C 指定玩家
---@param TargetObject AActor|UActorComponent 执行函数的实体
---@param FunctionName string 函数名
function ServerSystem.SendServerRPC(PlayerController, TargetObject, FunctionName, ...)
    UnrealNetwork.CallUnrealRPC(PlayerController, TargetObject, FunctionName, ...)
end

---服务端单播不可靠RPC
---@param PlayerController BP_UGCPlayerController_C 指定玩家
---@param TargetObject AActor|UActorComponent 执行函数的实体
---@param FunctionName string 函数名
function ServerSystem.SendServerRPC(PlayerController, TargetObject, FunctionName, ...)
    UnrealNetwork.CallUnrealRPC_Unreliable(PlayerController, TargetObject, FunctionName, ...)
end

---广播RPC
---@param TargetObject AActor|UActorComponent 执行函数的实体
---@param FunctionName string 函数名
function ServerSystem.SendMulticastRPC(TargetObject, FunctionName, ...)
    UnrealNetwork.CallUnrealRPC_Multicast(TargetObject, FunctionName, ...)
end

---广播不可靠RPC
---@param TargetObject AActor|UActorComponent 执行函数的实体
---@param FunctionName string 函数名
function ServerSystem.SendMulticastRPC_Unreliable(TargetObject, FunctionName, ...)
    UnrealNetwork.CallUnrealRPC_Multicast_Unreliable(TargetObject, FunctionName, ...)
end

return ServerSystem