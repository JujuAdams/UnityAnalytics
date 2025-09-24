// Feather disable all

/// @param sdkMethod
/// @param [highPriority=false]

function __UAEventGameRunning(_sdkMethod, _highPriority = false)
{
    var _payload = __UAConfigEventGameRunning();
    _payload.clientVersion = string(UA_GAME_CLIENT_VERSION);
    _payload.sdkMethod     = _sdkMethod;
    
    UAEvent(UA_EVENT_NAME_GAME_RUNNING, _payload, _highPriority, UA_EVENT_NAME_GAME_RUNNING_VERSION);
}