// Feather disable all

#macro UA_ENABLED      true
#macro UA_DEBUG_LEVEL  0  //0 = none, 1 = requests only, 2 = all debug messages

#macro UA_PROJECT_ID      ""
#macro UA_ENVIRONMENT_ID  ""

#macro UA_USER_ID_SALT  "JujuWazHere"

//Minutes before treating an out-of-focus as a new gameplay session
#macro UA_FOCUS_DETACH  30

//Minutes between heartbeats
#macro UA_HEARTBEAT_DELAY  1

#macro UA_MAX_PENDING_REQUESTS  10
#macro UA_MAX_PENDING_EVENTS_PER_REQUEST  20
#macro UA_SEND_DELAY  250 //milliseconds