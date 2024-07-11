// Feather disable all

/// @param forceAll

function __UASendPendingEvents(_forceAll)
{
    static _system            = __UASystem();
    static _sentEventMap      = _system.__sentEventMap;
    static _pendingEventArray = _system.__pendingEventArray;
    static _tempArray         = [];
    
    static _lastSend = -infinity;
    
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
            array_copy(_tempArray, 0, _pendingEventArray, 0, _count);
            array_delete(_pendingEventArray, 0, _count);
            
            //Send off what we have
            __UAPayloadSend({ eventList: _tempArray });
            
            //Size down the temporary array for the next request
            array_resize(_tempArray, 0);
        }
        
        if (_forceAll) __UASendPendingEvents(true);
    }
}