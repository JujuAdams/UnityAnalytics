// Feather disable all

/// This function returns a struct that is used to build the default Unity Analytics "gameEnded"
/// event. Please see UA documentation for more information.
/// 
/// https://services.docs.unity.com/analytics/v1/index.html
/// https://docs.unity.com/ugs/en-us/manual/analytics/manual/record-event-rest-api
/// 
/// N.B. This function can be called at unexpected times. Please write safe code here if you choose
///      to extend this data otherwise you'll run into nasty errors.

function __UAConfigEventUserEnded()
{
    return {
        //`clientVersion`, `sdkMethod`, and `userLocale` are automatically filled out by the library
    }
}