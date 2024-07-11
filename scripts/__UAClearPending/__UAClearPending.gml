// Feather disable all

function __UAClearPending()
{
    static _noUserEventArray  = __UASystem().__noUserEventArray;
    static _pendingEventArray = __UASystem().__pendingEventArray;
    
    array_resize(_noUserEventArray,  0);
    array_resize(_pendingEventArray, 0);
}