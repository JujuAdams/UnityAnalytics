// Feather disable all

/// Sends a "gameEnd" default UA event with the "crashed" session end state. This event uses data
/// set via __UAConfigEventUserEnded().
/// 
/// You should call this function when you detect a crash in your game, typically via GameMaker's
/// native exception_unhandled_handler() function.

function UAEventAppCrashed()
{
    __UAEventUserEnded("UAEventAppCrashed", __UA_SESSION_END_STATE_CRASHED, true);
    
    //Don't duplicate a crash event with a heartbeat
    file_delete(__UA_PATH_HEARTBEAT_DAT);
}