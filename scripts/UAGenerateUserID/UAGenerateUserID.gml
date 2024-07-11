// Feather disable all

/// Generates a 40-character hexadecimal string that can be used as a user ID with this library.
/// For simplicity, you might want to use UAEnsureUserID() instead if you're on a platform that
/// supports it (Windows, MacOS, Linux, Android, iOS, or tvOS).
/// 
/// Once you've generated a user ID for use with Unity Analytics, you should save it somewhere with
/// your player's savedata so it can be reused in the future to track the user journey.

function UAGenerateUserID()
{
    return __UAGenerateUUID(false);
}