// Feather disable all

/// Requests the deletion of analytics data for the currently set user ID. This request is always
/// executed with high priority. Unity Analytics documentation claims that deletion is guaranteed
/// to happen with seven days of the request.
/// 
/// N.B. You **must** provide a way for users to request that analytics data associated with their
///      user ID be deleted.
/// 
/// https://docs.unity.com/ugs/en-us/manual/analytics/manual/request-data-deletion-rest-api

function UARequestDeletion()
{
    static _system = __UASystem();
    
    var _payload = {};
    _payload.clientVersion = string(UA_GAME_CLIENT_VERSION);
    _payload.sdkMethod     = "UARequestDeletion";
    _payload.userLocale    = _system.__userLocale;
    
    UAEvent(UA_EVENT_NAME_DELETION_REQUESTED, _payload, true, UA_EVENT_NAME_DELETION_REQUESTED_VERSION);
}