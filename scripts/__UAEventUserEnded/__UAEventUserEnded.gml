// Feather disable all

/// @param sdkMethod
/// @param state 
/// @param [highPriority=false]

function __UAEventUserEnded(_sdkMethod, _endState, _highPriority = false)
{
    static _system = __UASystem();
    
    var _payload = __UAConfigEventUserEnded();
    _payload.sdkMethod       = _sdkMethod;
    _payload.sessionEndState = _endState;
    
    UAEvent(__UA_EVENT_NAME_USER_ENDED, _payload, _highPriority, int64(__UA_EVENT_NAME_USER_ENDED_VERSION));
}