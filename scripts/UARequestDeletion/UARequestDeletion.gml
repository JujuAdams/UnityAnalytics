// Feather disable all

/// Requests the deletion of analytics data for the currently set user ID. This request is always
/// executed with high priority. Unity Analytics documentation claims that deletion is guaranteed
/// to happen with seven days of the request.
/// 
/// N.B. You **must** provide a way for users to request that analytics data associated with their
///      user ID be deleted.
/// 
/// Documentation and commentary on this feature can be found at:
///     https://docs.unity.com/ugs/en-us/manual/analytics/manual/request-data-deletion-rest-api

function UARequestDeletion()
{
    static _system = __UASystem();
    
    if (_system.__userUUID == undefined)
    {
        if (UA_RUNNING_FROM_IDE)
        {
            __UAError("Cannot request deletion, user ID is unset");
        }
        else
        {
            __UATrace("Warning! Cannot request deletion, user ID is unset");
        }
        
        return;
    }
    
    if (UA_DEBUG_LEVEL >= 1) __UATrace("Requesting data deletion for user ID \"", _system.__userUUID, "\"");
    
    var _payload = {};
    _payload.clientVersion = string(UA_GAME_CLIENT_VERSION);
    _payload.sdkMethod     = "UARequestDeletion";
    
    var _event = new __UAClassEvent(_system.__userUUID, UA_EVENT_NAME_DELETION_REQUESTED_VERSION, UA_EVENT_NAME_DELETION_REQUESTED, _payload);
    __UAPayloadSend(_event);
}