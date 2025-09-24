// Feather disable all

/// Sets the current user's ID. You should call this function whenever a new user starts playing
/// your game, even if the game application itself has not been resetarted. This includes things
/// like account changes on consoles etc.
/// 
/// N.B. After calling `UASetUserID()`, you must call `UASetUserConsent()`. No analytics will be
///      sent until `UASetUserConsent()` is called.
/// 
/// The locale argument can be used to specify the user's system locale. If not specified, the
/// value returned by GameMaker's native `os_get_language()` is used instead.
/// 
/// Unity Analytics REST API documentation can be found at https://services.docs.unity.com/analytics/v1/index.html
/// 
/// @param userID
/// @param [locale]

function UASetUserID(_userID, _locale = os_get_language())
{
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
                __UAEventUserEnded(UA_METHOD_NAME_SET_USER, UA_SESSION_END_STATE_STOPPED);
                __UASendPendingEvents(false);
            }
            
            __userUUID       = undefined;
            __userStartTime  = undefined;
            __userLocale     = "xx";
            __userConsent    = false;
            __userConsentSet = false;
            
            return;
        }
        
        if (UA_USER_ID_SALT == undefined)
        {
            var _userUUID = _userID;
        }
        else
        {
            var _userUUID = sha1_string_utf8(sha1_string_utf8(string(_userID)) + string(UA_USER_ID_SALT));
        }
        
        if (__userUUID != _userUUID)
        {
            if (__userUUID != undefined)
            {
                if (UA_DEBUG_LEVEL >= 2) __UATrace("Setting user UUID to \"", _userUUID, "\" from \"", __userUUID, "\" (", _userID, ")");
                
                //Previous user stopped playing
                __UAEventUserEnded(UA_METHOD_NAME_SET_USER, UA_SESSION_END_STATE_STOPPED);
                __UASendPendingEvents(false);
            }
            else
            {
                if (UA_DEBUG_LEVEL >= 2) __UATrace("Set user UUID to \"", _userUUID, "\" (", _userID, ")");
            }
            
            __lastHeartbeatTime = -infinity;
            
            __userUUID       = _userUUID;
            __userStartTime  = date_current_datetime();
            __userLocale     = _locale;
            __userConsent    = false;
            __userConsentSet = false;
            __sessionID      = __UAGenerateUUID();
            
            //User started playing
            __UAEventUserStarted(UA_METHOD_NAME_SET_USER);
            
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