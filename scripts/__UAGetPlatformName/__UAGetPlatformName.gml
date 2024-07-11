// Feather disable all

function __UAGetPlatformName()
{
    static _platform = (function()
    {
        switch(os_type)
        {
            case os_windows:      return "PC_CLIENT";
            case os_macosx:       return "MAC_CLIENT";
            case os_ios:          return "IOS";
            case os_android:      return "ANDROID";
            case os_switch:       return "SWITCH";
            case os_ps5:          return "UNKNOWN"; //Not supported by Unity Analytics
            case os_ps4:          return "PS4";
            case os_xboxone:      return "XBOXONE";
            case os_xboxseriesxs: return "XBOXONE"; //Not supported by Unity Analytics but, yknow, close enough
            case os_linux:        return "UNKNOWN"; //Not supported by Unity Analytics
            case os_tvos:         return "IOS_TV";
            
            default: return "UNKNOWN";
        }
    })();
    
    return _platform;
}