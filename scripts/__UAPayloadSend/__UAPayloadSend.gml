// Feather disable all

/// @param payload

function __UAPayloadSend(_payload)
{
    static _sentEventMap = __UASystem().__sentEventMap;
    
    static _headerMap = (function()
    {
        var _map = ds_map_create();
        _map[? "Content-Type"] = "application/json";
        return _map;
    })();
    
    var _body = json_stringify(_payload);
	var _requestID = http_request(__UA_COLLECT_ENDPOINT, "POST", _headerMap, _body);
    
    if (UA_DEBUG_LEVEL >= 2) __UATrace("Request ID ", _requestID, " started          ", _body);
    _sentEventMap[? _requestID] = _payload;
}