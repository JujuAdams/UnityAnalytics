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
        
        __osPaused          = os_is_paused();
        __lastFocusTime     = current_time;
        __lastHeartbeatTime = -infinity;
        
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
        
        if (file_exists(UA_PATH_PENDING_DAT))
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
        
        if (UA_FILE_SYSTEM_ACCESS && file_exists(UA_PATH_HEARTBEAT_DAT))
        {
            if (UA_DEBUG_LEVEL >= 2) __UATrace("Found heartbeat data");
            
            try
            {
                var _buffer    = buffer_load(UA_PATH_HEARTBEAT_DAT);
                var _sessionID = buffer_read(_buffer, buffer_string);
                var _userUUID  = buffer_read(_buffer, buffer_string);
                var _timeCode  = buffer_read(_buffer, buffer_f64);
                buffer_delete(_buffer);
                
                var _payload = __UAConfigEventUserEnded();
                _payload.clientVersion   = string(UA_GAME_CLIENT_VERSION);
                _payload.sdkMethod       = UA_METHOD_NAME_ON_BOOT;
                _payload.sessionEndState = UA_SESSION_END_STATE_CRASHED;
                
                var _event = new __UAClassEvent(_userUUID, UA_EVENT_NAME_USER_ENDED_VERSION, _payload);
                //Override some properties
                _event.sessionID      = _sessionID;
                _event.eventTimestamp = __UAGenerateTimestamp(_timeCode);
                    
                //Send immediately
                __UAPayloadSend(_event);
            }
            catch(_error)
            {
                show_debug_message(_error);
                __UATrace("Warning! Failed to load old heartbeat data");
            }
            
            file_delete(UA_PATH_HEARTBEAT_DAT);
        }
    }
    
    time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function()
    {
        static _system = __UASystem();
        static _controllerInstance = undefined;
        static _heartbeatBuffer = buffer_create(1024, buffer_fixed, 1);
        
        with(_system)
        {
            if (os_is_paused() != __osPaused)
            {
                __osPaused = os_is_paused();
                
                if (__osPaused)
                {
                    //Focus restored, compare against last focus time
                    if ((__userUUID != undefined) && (current_time - __lastFocusTime > 60*1000*UA_FOCUS_DETACH))
                    {
                        __UAEventUserEnded(UA_METHOD_NAME_GAME_LOST_FOCUS, UA_SESSION_END_STATE_PAUSED);
                        
                        __lastHeartbeatTime = -infinity;
                        
                        __userStartTime = date_current_datetime();
                        __sessionID     = __UAGenerateUUID();
                        __UAEventUserStarted(UA_METHOD_NAME_GAME_REGAINED_FOCUS);
                    }
                }
            }
            
            if (not __osPaused)
            {
                __lastFocusTime = current_time;
                    
                if (UA_FILE_SYSTEM_ACCESS
                &&  (current_time - __lastHeartbeatTime > 60*1000*UA_HEARTBEAT_DELAY)
                &&  (__userUUID != undefined))
                {
                    __lastHeartbeatTime = current_time;
                    
                    var _timeCode = date_current_datetime();
                    
                    buffer_seek(_heartbeatBuffer, buffer_seek_start, 0);
                    buffer_write(_heartbeatBuffer, buffer_string, __sessionID);
                    buffer_write(_heartbeatBuffer, buffer_string, __userUUID);
                    buffer_write(_heartbeatBuffer, buffer_f64, _timeCode);
                    buffer_save_ext(_heartbeatBuffer, UA_PATH_HEARTBEAT_DAT, 0, buffer_tell(_heartbeatBuffer));
                     
                    if (UA_DEBUG_LEVEL >= 2) __UATrace("Saving heartbeat data");
                }
            }
            
            if ((_controllerInstance != undefined) && (not instance_exists(_controllerInstance)))
            {
                if (UA_RUNNING_FROM_IDE)
                {
                    __UAError("UnityAnalyticsController must not be destroyed or deactivated");
                }
                else
                {
                    _controllerInstance = undefined;
                    __UATrace("Warning! UnityAnalyticsController was destroyed or deactivated");
                }
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