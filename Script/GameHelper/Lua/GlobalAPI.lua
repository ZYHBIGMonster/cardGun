-----------------------------------------------------------全局API----------------------------------------------------------------
IsValid = IsValid or function(Object)
    return Object ~= nil and UE.IsValid(Object)
end

---是否服务端
---@param Actor AActor
IsServer = IsServer or function(Actor)
    if UGCGameSystem.GameState then return UGCGameSystem.IsServer() end
    if not Actor then print("[LuaException] IsServer() No Actor") return false end
    return Actor:HasAuthority()
end

print_f = print_f or function(str, ...)
    print(string.format(str, ...))
end

ugcprint_f = ugcprint_f or function(str, ...)
    ugcprint(string.format(str, ...))
end