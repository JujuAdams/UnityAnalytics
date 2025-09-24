// Feather disable all

/// Returns whether the current user has given consent for analytics to be collected, as set by
/// `UASetUserConsent()`. This function will return `false` after calling `UASetUserID()` if you
/// have not called `UASetUserConsent()`.

function UAGetUserConsent()
{
    static _system = __UASystem();
    return _system.__userConsent;
}