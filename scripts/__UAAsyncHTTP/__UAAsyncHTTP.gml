// Feather disable all

function __UAAsyncHTTP()
{
    static _sentEventMap = __UASystem().__sentEventMap;
    
    var _requestID = async_load[? "id"];
    
    var _payload = _sentEventMap[? _requestID];
    if (_payload != undefined)
    {
        ds_map_delete(_sentEventMap, _requestID);
        
        if (async_load[? "status"] < 0)
        {
            if (async_load[? "http_status"] == "200")
            {
                __UATrace("Warning! Request ", _requestID, " successful but will unexpected HTTP 200 return");
            }
            else if (async_load[? "http_status"] == "204")
            {
                if (UA_DEBUG_LEVEL >= 2) __UATrace("Request ", _requestID, " successful");
            }
            else
            {
                __UATrace("Warning! Request ", _requestID, " failed. Payload was:");
                __UATrace(_payload);
            }
        }
    }
}