// Feather disable all

/// @param [timeCode=current]

function __UAGenerateTimestamp(_timeCode = date_current_datetime())
{
    var _year   = date_get_year(  _timeCode);
    var _month  = date_get_month( _timeCode);
    var _day    = date_get_day(   _timeCode);
    var _hour   = date_get_hour(  _timeCode);
    var _minute = date_get_month( _timeCode);
    var _second = date_get_second(_timeCode);
    
    ///"yyyy-mm-dd hh:mm:ss.SSS"
    //We don't bother with milliseconds as GM's datetime functions aren't accurate enough
    return $"{_year}-{_month}-{_day} {_hour}:{_minute}:{_second}.000";
}