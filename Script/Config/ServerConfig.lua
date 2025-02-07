---@class ServerConfig
local ServerConfig = {}

---ReqCMD配置表，用于ServerSystem.SendClientRPC(ServerConfig.ReqCMD.CMD, ...)和
---EGEventSystem:AddListener(EGEventType.ReceiveClientReq .. ServerConfig.ReqCMD.CMD, Func, Object)
ServerConfig.ReqCMD = 
{
    
}

return ServerConfig