// Feather disable all

/// Unity Analytics documentation can be found at:
///    https://services.docs.unity.com/analytics/v1/index.html
///    https://docs.unity.com/ugs/en-us/manual/analytics/manual/overview

#macro UA_VERSION  "2.1.0"
#macro UA_DATE     "2025-09-24"

#macro UA_RUNNING_EVENT_DELAY  (60*1000) //ms
#macro UA_MAX_EVENT_COUNT  100

#macro UA_COLLECT_ENDPOINT  ("https://collect.analytics.unity3d.com/api/analytics/collect/v1/projects/" + UA_PROJECT_ID + "/environments/" + UA_ENVIRONMENT_ID)

#macro UA_RUNNING_FROM_IDE  (GM_build_type == "run")

/// Magic values to interface with Unity Analytics' standard events.
#macro UA_EVENT_NAME_USER_STARTED                "gameStarted"
#macro UA_EVENT_NAME_USER_STARTED_VERSION        1
#macro UA_EVENT_NAME_GAME_RUNNING                "gameRunning"
#macro UA_EVENT_NAME_GAME_RUNNING_VERSION        1
#macro UA_EVENT_NAME_USER_ENDED                  "gameEnded"
#macro UA_EVENT_NAME_USER_ENDED_VERSION          1
#macro UA_EVENT_NAME_DELETION_REQUESTED          "ddnaForgetMe"
#macro UA_EVENT_NAME_DELETION_REQUESTED_VERSION  1

/// These are arbitrary strings used to indicate the code origin of events.
#macro UA_SDK_METHOD_SET_USER               "UASetUser"
#macro UA_SDK_METHOD_GAME_LOST_FOCUS        "game lost focus"
#macro UA_SDK_METHOD_GAME_REGAINED_FOCUS    "game regained focus"
#macro UA_SDK_METHOD_GAME_END_EVENT         "Game End event"
#macro UA_SDK_METHOD_APP_CRASHED            "UAEventAppCrashed"
#macro UA_SDK_METHOD_USER_WITHDREW_CONSENT  "UASetUserConsent"
#macro UA_SDK_METHOD_HEARTBEAT              "system heartbeat"

/// These are arbitrary too and are used for the game state when the "gameEnded" event is emitted.
#macro UA_SESSION_END_STATE_PAUSED   "paused"
#macro UA_SESSION_END_STATE_STOPPED  "stopped"
#macro UA_SESSION_END_STATE_CRASHED  "crashed"

#macro UA_FILE_SYSTEM_ACCESS  ((os_type == os_windows) || (os_type == os_macosx) || (os_type == os_linux) || (os_type == os_android) || (os_type == os_ios) || (os_type == os_tvos))

#macro UA_PATH_PENDING_DAT  "uapending.dat"