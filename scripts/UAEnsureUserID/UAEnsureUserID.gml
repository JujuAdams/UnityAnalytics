// Feather disable all

/// @param savePath

function UAEnsureUserID(_path)
{
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