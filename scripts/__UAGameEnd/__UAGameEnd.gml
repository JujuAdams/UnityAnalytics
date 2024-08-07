// Feather disable all

function __UAGameEndEvent()
{
    static _system = __UASystem();
    with(_system)
    {
        if (__userUUID == undefined) return;
        
        __UAConfigCallbackGameEnded();
        __UAEventUserEnded("GameEndEvent", __UA_SESSION_END_STATE_STOPPED);
        __UASendPendingEvents(true);
        
        //Remove the heartbeat file since we've detected the end of the game
        file_delete(__UA_PATH_HEARTBEAT_DAT);
        
        //Save all pending payloads
        var _pendingPayloadArray = ds_map_values_to_array(__sentEventMap);
        
        var _buffer = buffer_create(1024, buffer_grow, 1);
        buffer_write(_buffer, buffer_string, json_stringify(_pendingPayloadArray));
        buffer_save_ext(_buffer, __UA_PATH_PENDING_DAT, 0, buffer_tell(_buffer));
    }
}