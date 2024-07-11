// Feather disable all

/// @param userID
/// @param [locale]

function UASetUserID(_userID, _locale = os_get_language())
{
    if (not UA_ENABLED) return;
    
    static _system = __UASystem();
    
    with(_system)
    {
        if (_userID == undefined)
        {
            //Unset the current user
            
            if (__userUUID != undefined)
            {
                if (UA_DEBUG_LEVEL >= 2) __UATrace("Unsetting user UUID from \"", __userUUID, "\"");
                
                //Previous user stopped playing
                __UAEventUserEnded("UASetUser", __UA_SESSION_END_STATE_STOPPED);
            }
            
            __userUUID      = undefined;
            __userStartTime = undefined;
            __userLocale    = "xx";
            
            return;
        }
        
        if (UA_USER_ID_SALT == undefined)
        {
            var _userUUID = _userID;
        }
        else
        {
            var _userUUID = sha1_string_utf8(sha1_string_utf8(string(_userID)) + UA_USER_ID_SALT);
        }
        
        if (__userUUID != _userUUID)
        {
            if (__userUUID != undefined)
            {
                if (UA_DEBUG_LEVEL >= 2) __UATrace("Setting user UUID to \"", _userUUID, "\" from \"", __userUUID, "\" (", _userID, ")");
                
                //Previous user stopped playing
                __UAEventUserEnded("UASetUser", __UA_SESSION_END_STATE_STOPPED);
            }
            else
            {
                if (UA_DEBUG_LEVEL >= 2) __UATrace("Set user UUID to \"", _userUUID, "\" (", _userID, ")");
            }
            
            __lastHeartbeatTime = -infinity;
            
            __userUUID      = _userUUID;
            __userStartTime = date_current_datetime();
            __userLocale    = _locale;
            __sessionID     = __UAGenerateUUID();
            
            //User started playing
            __UAEventUserStarted("UASetUser");
            
            //Retag all events without a user ID
            var _i = 0;
            repeat(array_length(__noUserEventArray))
            {
                with(__noUserEventArray[_i])
                {
                    userID = _userUUID;
                    
                    //Set the session ID for unsessioned events
                    if (self[$ "sessionID"] == undefined)
                    {
                        sessionID = _system.__sessionID;
                    }
                    
                    //Set the user locale for the default parameters
                    if (struct_exists(eventParams, "userLocale"))
                    {
                        eventParams.userLocale = _locale;
                    }
                }
                
                ++_i;
            }
            
            //Copy the no user events into our pending queue
            array_copy(__pendingEventArray, array_length(__pendingEventArray), __noUserEventArray, 0, array_length(__noUserEventArray));
            
            //Clear out the old events
            array_resize(__noUserEventArray, 0);
        }
    }
}