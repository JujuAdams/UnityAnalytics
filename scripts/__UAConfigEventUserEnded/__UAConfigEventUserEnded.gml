// Feather disable all

/// This function returns a struct that is used to build the default Unity Analytics "gameEnded"
/// event. Please see UA documentation for more information.
/// 
/// N.B. This function can be called at unexpected times. Please write safe code here if you choose
///      to extend this data otherwise you'll run into nasty errors.

function __UAConfigEventUserEnded()
{
    return {
        clientVersion: GM_version, //Required by UA!
        
        //sdkMethod and sessionEndState are automatically filled out by the library
    }
}