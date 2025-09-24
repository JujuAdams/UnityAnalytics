// Feather disable all

/// Unity Analytics REST API documentation can be found at https://services.docs.unity.com/analytics/v1/index.html

/// Identifiers for your project and project environment. You can retrieve these values from the
/// Unity Analytics backend. You must fill out these values before this library will work.
#macro UA_PROJECT_ID      ""
#macro UA_ENVIRONMENT_ID  "production"

/// Game version string, used to determine the `.clientVersion` field for events.
#macro UA_GAME_CLIENT_VERSION  GM_version

/// Debug level for the library. This affects how "noisy" the library is whilst it's doing its
/// thing. A high debug level of 2 is useful for debugging issues but can make it hard to read
/// your debug log;
/// 
/// 0 = No debug messages
/// 1 = Show debug messages for requests only
/// 2 = Show as many debug messages as possible
#macro UA_DEBUG_LEVEL  0

/// Minutes before treating out-of-focus as a new gameplay session. Set this value to `infinity`
/// if you want to turn off this feature.
#macro UA_FOCUS_DETACH  30

/// How often (in minutes) to save a small file to record when the game was last active. This can
/// be used to detect unexpected terminations of the game. This feature is only enabled on Windows,
/// MacOS, Linux, Android, iOS, and tvOS. If you don't want to use this feature, set the macro to
/// `infinity`.
#macro UA_HEARTBEAT_DELAY  5

/// Internal string used to protect user privacy. If you would like to use literal user IDs for your
/// analytics, set this macro to `undefined`. You should only ever do this for testing purposes.
#macro UA_USER_ID_SALT  UA_PROJECT_ID

/// Various parameters to control how hard you're hitting the Unity Analytics servers. You probably
/// won't need to change these.
#macro UA_MAX_PENDING_REQUESTS     10
#macro UA_MAX_EVENTS_PER_REQUEST   20
#macro UA_SEND_DELAY              150 //milliseconds