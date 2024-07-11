// Feather disable all

function UAGetUserID()
{
    if (not UA_ENABLED) return false;
    
    static _system = __UASystem();
    
    return _system.__userUUID;
}