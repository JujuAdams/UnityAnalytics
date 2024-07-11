// Feather disable all

/// @param [highPriority=true]

function UAEventAppCrashed(_highPriority = true)
{
    if (not UA_ENABLED) return;
    
    __UAEventUserEnded("UAEventAppCrashed", __UA_SESSION_END_STATE_CRASHED, _highPriority);
    
    //Don't duplicate a crash event with a heartbeat
    file_delete(__UA_PATH_HEARTBEAT_DAT);
}