// Feather disable all

/// @param forceAll

function __UASendPendingEvents(_forceAll)
{
    static _system            = __UASystem();
    static _sentEventMap      = _system.__sentEventMap;
    static _pendingEventArray = _system.__pendingEventArray;
    
    static _lastSend = -infinity;
    
    //We don't know whether the user consented or not, don't send anything
    if (not _system.__userConsentSet) return;
    
    var _length = array_length(_pendingEventArray);
    if (_length > 0)
    {
        if ((not _forceAll) && (ds_map_size(_sentEventMap) > UA_MAX_PENDING_REQUESTS))
        {
            __UATrace("Warning! Exceeded maximum pending requests ", UA_MAX_PENDING_REQUESTS);
        }
        else if (_forceAll || (current_time - _lastSend > UA_SEND_DELAY))
        {
            _lastSend = current_time;
            var _count = min(_length, UA_MAX_EVENTS_PER_REQUEST);
            
            //Copy a small block of data from the pending event array
            //We have to make a new array here so that the pending requests system works
            var _tempArray = array_create(_count);
            array_copy(_tempArray, 0, _pendingEventArray, 0, _count);
            array_delete(_pendingEventArray, 0, _count);
            
            //Send off what we have
            __UAPayloadSend({ eventList: _tempArray });
        }
        
        if (_forceAll)
        {
            //Recursively call this function until all events have been sent
            __UASendPendingEvents(true);
        }
    }
}