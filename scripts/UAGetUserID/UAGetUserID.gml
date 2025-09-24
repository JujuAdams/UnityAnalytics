// Feather disable all

/// Returns the user ID, as set by `UASetUserID()`. If no user ID has been set then this function
/// returns `undefined`.

function UAGetUserID()
{
    static _system = __UASystem();
    
    return _system.__userUUID;
}