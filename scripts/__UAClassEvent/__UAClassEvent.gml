// Feather disable all

/*
{
    "eventName": "specific event code - eg. gameStarted",
    "userID": "ABCD1-4321a879b185fcb9c6ca27abc5387e914",
    "sessionID": "4879bf37-8566-46ce-9f3b-bd18d6ac614e",
    "eventUUID": "374cc674-9785-4772-8cca-d7cdf517a590",
    "eventTimestamp": "yyyy-mm-dd hh:mm:ss.SSS",
    "eventParams": {
        "platform": "WEB",
        "param1": "stringParam",
        "param2": true,
        "param3": 1234,
        "param4": [
            "a",
            "b",
            "c"
        ]
    }
}
*/

/// @param userID
/// @param [eventVersion]
/// @param eventName
/// @param eventParams

function __UAClassEvent(_userID, _eventVersion = undefined, _eventName, _eventParams) constructor
{
    eventName      = _eventName;
    userID         = _userID;
    sessionID      = __UASystem().__sessionID;
    eventUUID      = __UAGenerateUUID();
    eventTimestamp = __UAGenerateTimestamp();
    eventParams    = _eventParams;
    
    _eventParams.platform = __UAGetPlatformName();
    if (_eventVersion != undefined) eventVersion = _eventVersion;
    
    //DO NOT ADD STATICS OR METHODS TO THIS CLASS
}