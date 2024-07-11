// Feather disable all

function __UASendPendingEvents()
{
    static _sentEventMap      = __UASystem().__sentEventMap;
    static _pendingEventArray = __UASystem().__pendingEventArray;
    static _tempArray         = [];
    
    static _lastSend = -infinity;
    
    var _length = array_length(_pendingEventArray);
    if (_length > 0)
    {
        if (ds_map_size(_sentEventMap) > UA_MAX_PENDING_REQUESTS)
        {
            __UATrace("Warning! Exceed maximum pending requests ", UA_MAX_PENDING_REQUESTS);
        }
        else if (current_time - _lastSend > UA_SEND_DELAY)
        {
            _lastSend = current_time;
            var _count = min(_length, UA_MAX_PENDING_EVENTS_PER_REQUEST);
            
            //Copy a small block of data from the pending event array
            array_copy(_tempArray, 0, _pendingEventArray, 0, _count);
            array_delete(_pendingEventArray, 0, _count);
            
            //Send off what we have
            __UAPayloadSend(json_stringify({ eventList: _tempArray }));
            
            //Size down the temporary array for the next request
            array_resize(_tempArray, 0);
        }
    }
}