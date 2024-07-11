// Feather disable all

/// @param eventName
/// @param eventParamsStruct
/// @param [highPriority=false]
/// @param [eventVersion]

function UAEvent(_eventName, _eventParams, _highPriority = false, _eventVersion = undefined)
{
    if (not UA_ENABLED) return;
    
    static _system            = __UASystem();
    static _noUserEventArray  = __UASystem().__noUserEventArray;
    static _pendingEventArray = __UASystem().__pendingEventArray;
    
    var _eventArray = (_system.__userUUID == undefined)? _noUserEventArray : _pendingEventArray;
    
    var _event = new __UAClassEvent(_system.__userUUID, _eventVersion, _eventName, _eventParams);
    
    if (UA_DEBUG_LEVEL >= 1) __UATrace(_eventName, (_eventVersion != undefined)? (" (v" + string(_eventVersion) + ") ") : " ", _highPriority? "PRIORITY" : "", ": ", json_stringify(_eventParams));
    
    if (_highPriority)
    {
        __UAPayloadSend(_event);
    }
    else
    {
        array_push(_eventArray, _event);
    }
}