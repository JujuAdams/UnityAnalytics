// Feather disable all

/// Unity Analytics REST API documentation can be found at https://services.docs.unity.com/analytics/v1/index.html

#macro UA_VERSION  "2.0.1"
#macro UA_DATE     "2024-07-11"

#macro UA_COLLECT_ENDPOINT  ("https://collect.analytics.unity3d.com/api/analytics/collect/v1/projects/" + UA_PROJECT_ID + "/environments/" + UA_ENVIRONMENT_ID)

#macro UA_RUNNING_FROM_IDE  (GM_build_type == "run")

/// Magic values to interface with Unity Analytics' standard events.
#macro UA_EVENT_NAME_USER_STARTED          "gameStarted"
#macro UA_EVENT_NAME_USER_STARTED_VERSION  1
#macro UA_EVENT_NAME_USER_ENDED            "gameEnded"
#macro UA_EVENT_NAME_USER_ENDED_VERSION    1

/// I wrote this code a while ago so I have no idea where these magic strings have come from.
/// Maybe if you send an invalid standard event the error message tells you?
#macro UA_METHOD_NAME_SET_USER               "UASetUser"
#macro UA_METHOD_NAME_GAME_LOST_FOCUS        "GameLostFocus"
#macro UA_METHOD_NAME_GAME_REGAINED_FOCUS    "GameRegainedFocus"
#macro UA_METHOD_NAME_GAME_END_EVENT         "GameEndEvent"
#macro UA_METHOD_NAME_APP_CRASHED            "UAEventAppCrashed"
#macro UA_METHOD_NAME_USER_WITHDREW_CONSENT  "UserWithdrewConsent"
#macro UA_METHOD_NAME_ON_BOOT                "OnBoot"

/// Similarly, I don't remember where these come from either.
#macro UA_SESSION_END_STATE_PAUSED   "paused"
#macro UA_SESSION_END_STATE_STOPPED  "stopped"
#macro UA_SESSION_END_STATE_CRASHED  "crashed"

#macro UA_FILE_SYSTEM_ACCESS  ((os_type == os_windows) || (os_type == os_macosx) || (os_type == os_linux) || (os_type == os_android) || (os_type == os_ios) || (os_type == os_tvos))

#macro UA_PATH_HEARTBEAT_DAT  "uaheartbeat.dat"
#macro UA_PATH_PENDING_DAT    "uapending.dat"