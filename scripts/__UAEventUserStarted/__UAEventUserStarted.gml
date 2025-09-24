// Feather disable all

/// @param sdkMethod
/// @param [highPriority=false]

function __UAEventUserStarted(_sdkMethod, _highPriority = false)
{
    static _system = __UASystem();
    
    var _payload = __UAConfigEventUserStarted();
    _payload.sdkMethod  = _sdkMethod;
    _payload.userLocale = _system.__userLocale;
    
    UAEvent(UA_EVENT_NAME_USER_STARTED, _payload, _highPriority, UA_EVENT_NAME_USER_STARTED_VERSION);
}