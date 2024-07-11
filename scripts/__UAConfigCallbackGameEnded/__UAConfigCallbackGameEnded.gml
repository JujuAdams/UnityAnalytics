// Feather disable all

/// This function is called when the game ends normally (i.e. the user chose to close the game)
/// and before this library sends off its on-close analytics events. You should use this callback
/// to send off any events that you want to trigger when the user has closed the game, for example
/// tracking what level the user closed the game on.
/// 
/// Events created in this callback will be sent immediately as the game closes so setting "high
/// priority" for calls to UAEvent() is unnecessary.

function __UAConfigCallbackGameEnded()
{
    //e.g.
    //
    //UAEvent("userQuitTheGame", {
    //    room: room_get_name(room),
    //});
}