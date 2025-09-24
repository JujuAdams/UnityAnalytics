// Unity Analytics REST API documentation can be found at https://services.docs.unity.com/analytics/v1/index.html

__UASystem();
function __UASystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    with(_system)
    {
        if (debug_mode)
        {
            global.__UnityAnalytics = self;
        }
        
        __userConsent    = false;
        __userConsentSet = false;
        
        __osPaused        = os_is_paused();
        __lastFocusTime   = current_time;
        __lastRunningTime = current_time;
        
        __userUUID      = undefined;
        __userStartTime = undefined;
        __userLocale    = "xx";
        __sessionID     = undefined;
        
        __noUserEventArray  = [];
        __pendingEventArray = [];
        
        __sentEventMap = ds_map_create();
        
        __UATrace("Welcome to Unity Analytics by Juju Adams! This is version ", UA_VERSION, " ", UA_DATE, "(GameMaker ", GM_version, ")");
        
        if (UA_PROJECT_ID == "")
        {
            __UAError("The project ID has not been set.\nPlease see the __UAConfig script.");
        }
        
        if (UA_FILE_SYSTEM_ACCESS && file_exists(UA_PATH_PENDING_DAT))
        {
            if (UA_DEBUG_LEVEL >= 2) __UATrace("Found pending event data");
            
            try
            {
                var _buffer = buffer_load(UA_PATH_PENDING_DAT);
                var _pendingArray = buffer_read(_buffer, buffer_string);
                buffer_delete(_buffer);
                
                var _pendingArray = json_parse(_pendingArray);
                
                var _i = 0;
                repeat(array_length(_pendingArray))
                {
                    __UAPayloadSend(_pendingArray[_i]);
                    ++_i;
                }
            }
            catch(_error)
            {
                show_debug_message(_error);
                __UATrace("Warning! Failed to load old pending data");
            }
            
            file_delete(UA_PATH_PENDING_DAT);
        }
    }
    
    time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function()
    {
        static _system = __UASystem();
        static _controllerInstance = undefined;
        
        with(_system)
        {
            if ((_controllerInstance != undefined) && (not instance_exists(_controllerInstance)))
            {
                if (UA_RUNNING_FROM_IDE)
                {
                    __UAError("Object instance `UnityAnalyticsController` must not be destroyed or deactivated");
                }
                else
                {
                    _controllerInstance = undefined;
                    __UATrace("Warning! Object instance `UnityAnalyticsController` was destroyed or deactivated");
                }
            }
            
            if (os_is_paused() != __osPaused)
            {
                __osPaused = os_is_paused();
                
                if (__osPaused)
                {
                    //Focus restored, compare against last focus time
                    if ((__userUUID != undefined) && (current_time - __lastFocusTime > 60*1000*UA_FOCUS_DETACH))
                    {
                        __UAEventUserEnded(UA_METHOD_NAME_GAME_LOST_FOCUS, UA_SESSION_END_STATE_PAUSED);
                        
                        __lastRunningTime = current_time;
                        
                        __userStartTime = date_current_datetime();
                        __sessionID     = __UAGenerateUUID();
                        __UAEventUserStarted(UA_METHOD_NAME_GAME_REGAINED_FOCUS);
                    }
                }
            }
            
            if (not __osPaused)
            {
                __lastFocusTime = current_time;
            }
            
            if ((current_time - __lastRunningTime > UA_RUNNING_EVENT_DELAY) && (__userUUID != undefined) && __userConsentSet)
            {
                __UAEventGameRunning(UA_METHOD_NAME_HEARTBEAT);
            }
            
            if (_controllerInstance == undefined)
            {
                _controllerInstance = instance_create_depth(0, 0, 0, UnityAnalyticsController);
            }
            
            __UASendPendingEvents(false);
        }
        
    }, [], -1));
    
    return _system;
}