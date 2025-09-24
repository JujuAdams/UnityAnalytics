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
    
    _month  = (_month  >= 10)? string(_month ) : ("0" + string(_month ));
    _day    = (_day    >= 10)? string(_day   ) : ("0" + string(_day   ));
    _hour   = (_hour   >= 10)? string(_hour  ) : ("0" + string(_hour  ));
    _minute = (_minute >= 10)? string(_minute) : ("0" + string(_minute));
    _second = (_second >= 10)? string(_second) : ("0" + string(_second));
    
    ///"yyyy-mm-dd hh:mm:ss.SSS"
    //We don't bother with milliseconds as GM's datetime functions aren't accurate enough
    return $"{_year}-{_month}-{_day} {_hour}:{_minute}:{_second}.000";
}