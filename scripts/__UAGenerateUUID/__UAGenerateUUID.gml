// Feather disable all

/// @param [hyphenate=true]

function __UAGenerateUUID(_hyphenate = true)
{
    //As per https://www.cryptosys.net/pki/uuid-rfc4122.html (though without the hyphens)
    var _UUID = md5_string_unicode(string(current_time) + string(date_current_datetime()) + string(__UAXORShift32Random(1000000)));
    _UUID = string_set_byte_at(_UUID, 13, ord("4"));
    _UUID = string_set_byte_at(_UUID, 17, ord(__UAXORShift32Choose("8", "9", "a", "b")));
    
    if (_hyphenate)
    {
        _UUID = string_copy(_UUID, 1, 8) + "-" + string_copy(_UUID, 9, 4) + "-" + string_copy(_UUID, 13, 4) + "-" + string_copy(_UUID, 17, 4) + "-" + string_copy(_UUID, 21, 12);
    }
    
    return _UUID;
}

//Basic XORShift32, nothing fancy
function __UAXORShift32Random(_value)
{
    static _state = floor(1000000*date_current_datetime() + display_mouse_get_x() + display_get_width()*display_mouse_get_y());
    _state ^= _state << 13;
    _state ^= _state >> 17;
    _state ^= _state <<  5;
    return _value * abs(_state) / (real(0x7FFFFFFFFFFFFFFF) + 1.0);
}

function __UAXORShift32Choose()
{
    return argument[floor(__UAXORShift32Random(argument_count))];
}
