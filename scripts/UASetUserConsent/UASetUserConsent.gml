// Feather disable all

/// Sets whether the user has consented to analytics being collected. You should call this *after*
/// `UASetUserID()` for the user giving (or declining) consent. You should further call this
/// function if the user changes their consent status. You should also call this function every
/// time the game boots, usually from the point at which userdata is loaded.
/// 
/// N.B. If you don't call this function then no analytics data will be sent.
/// 
/// @param state

function UASetUserConsent(_state)
{
    static _system = __UASystem();
    
    if (_system.__userUUID == undefined)
    {
        __UATrace("Warning! Cannot set user consent state without a user set");
        return;
    }
    
    if (not _state)
    {
        if (_system.__userConsentSet)
        {
            if (_system.__userConsent)
            {
                __UAEventUserEnded(UA_METHOD_NAME_USER_WITHDREW_CONSENT, UA_SESSION_END_STATE_STOPPED);
            }
        }
        else
        {
            //Clear out all events because the user opted out
            __UAClearPending();
        }
    }
    
    _system.__userConsent    = _state;
    _system.__userConsentSet = true;
}