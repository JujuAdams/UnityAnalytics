/// @param text
/// @param callback
/// @param [data=undefined]

function UIButton(_text, _callback, _eventParams = undefined)
{
    UIButtonInline(_text, _callback, _eventParams);
    UINewline();
}