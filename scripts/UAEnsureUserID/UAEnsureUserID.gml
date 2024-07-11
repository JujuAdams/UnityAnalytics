// Feather disable all

/// Tries to find a user ID in a specific file in storage. If a user ID cannot be found, a new user
/// ID is generated and saved to storage. This means that the user ID is consistent between play
/// sessions allowing you to track the user journey. Once you have obtained a user ID with this
/// function, you should call UASetUserID() to initialize the library for that user.
/// 
/// If you have a separate unique user ID available to you, for example a Steam ID, then you don't
/// need to use this function and you can instead pass the existing user ID into UASetUserID().
/// 
/// @param savePath

function UAEnsureUserID(_path)
{
    if (not __UA_FILE_SYSTEM_ACCESS)
    {
        __UAError("Cannot use UAEnsureUserID() on this platform\nPlease manually generate a user ID (or use a platform user ID)");
    }
    
    var _userID = undefined;
    
    if (file_exists(_path))
    {
        try
        {
            var _buffer = buffer_load(_path);
            var _userID = buffer_read(_buffer, buffer_string);
            buffer_delete(_buffer);
        }
        catch(_error)
        {
            if (UA_DEBUG_LEVEL >= 2) show_debug_message(_error);
            if (UA_DEBUG_LEVEL >= 1) __UATrace("Error encountered whilst loading user ID from \"", _path, "\"");
            
            _userID = undefined;
        }
    }
    
    if (_userID == undefined)
    {
        if (UA_DEBUG_LEVEL >= 1) __UATrace("No user ID found at \"", _path, "\", creating a new user ID");
        var _userID = UAGenerateUserID();
        
        var _buffer = buffer_create(string_byte_length(_userID), buffer_fixed, 1);
        buffer_write(_buffer, buffer_text, _userID);
        buffer_save(_buffer, _path);
        buffer_delete(_buffer);
    }
    
    return _userID;
}