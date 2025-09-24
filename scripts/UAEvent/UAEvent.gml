// Feather disable all

/// Creates an analytics event and queues it for sending. This event corresponds to either a
/// default UA event or a custom UA event, as set up in the Unity Analytics backend.
/// 
/// Events will not be processed at all if `UASetUserConsent()` is used to set decline consent.
/// WHether the user has given consent is reset after calling `UASetUserID()` so make sure to call
/// `UASetUserConsent()` as soon as possible. In the time between setting the user ID and giving
/// consent (or declining) consent, events will be queued up. This means that events queued up
/// before user consent to given will still be sent, albeit only after consent is given.
/// 
/// If an event is marked as "high priority" then, if possible, that event will be sent immediately
/// and not queued for sending later. You almost certainly won't need to use this feature but it's
/// there if you need it.
/// 
/// When triggering events that correspond to default Unity Analytics events, you may find that you
/// need to specify an event version. This can be done with the corresponding optional argument for
/// this function.
/// 
/// Unity Analytics REST API documentation can be found at https://services.docs.unity.com/analytics/v1/index.html
/// 
/// @param eventName
/// @param eventParamsStruct
/// @param [highPriority=false]
/// @param [eventVersion]

function UAEvent(_eventName, _eventParams, _highPriority = false, _eventVersion = undefined)
{
    static _system            = __UASystem();
    static _noUserEventArray  = _system.__noUserEventArray;
    static _pendingEventArray = _system.__pendingEventArray;
    
    //Don't queue up events if the user hasn't consented
    if (_system.__userConsentSet && (not _system.__userConsent)) return;
    
    //Stack up event in a separate array if no user ID has been set yet
    //If an event ends up in the "no user" array then we'll retag those events when setting a user ID
    var _eventArray = (_system.__userUUID == undefined)? _noUserEventArray : _pendingEventArray;
    
    //Create a new event struct
    var _event = new __UAClassEvent(_system.__userUUID, _eventVersion, _eventName, _eventParams);
    if (UA_DEBUG_LEVEL >= 1) __UATrace(_eventName, (_eventVersion != undefined)? (" (v" + string(_eventVersion) + ") ") : " ", _highPriority? "PRIORITY" : "", ": ", json_stringify(_eventParams));
    
    if (_highPriority && _system.__userConsentSet)
    {
        //Only immediately send a payload if the user consent state has been set
        __UAPayloadSend(_event);
    }
    else
    {
        //Queue this event
        array_push(_eventArray, _event);
    }
}