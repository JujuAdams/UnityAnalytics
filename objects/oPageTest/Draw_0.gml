UIStart(10, 10);
UIText("Unity Analytics " + UA_VERSION);
UINewline();
UIButton("Unset user ID", function()
{
    UASetUserID(undefined);
    instance_destroy();
    instance_create_depth(0, 0, 0, oPageLanding);
});
UINewline();
UIButton("Send test event", function()
{
    UAEvent("jujusCustomEvent", {
        jujusTestParameter: 42,
    });
});
UINewline();
UIButton("Send test event immediatly", function()
{
    UAEvent("jujusCustomEvent", {
        jujusTestParameter: 28,
    }, true);
});
UINewline();
UIButton("Send three test events", function()
{
    repeat(3)
    {
        UAEvent("jujusCustomEvent", {
            jujusTestParameter: 28,
        });
    }
});
UINewline();
UIButton("Test UAEventAppCrashed()", function()
{
    exception_unhandled_handler(function()
    {
        UAEventAppCrashed();
        show_message("The game crashed!");
    });
    
    show_error("Forced error to test UAEventAppCrashed()", true);
});
UINewline();
UIButton("Request deletion", function()
{
    UARequestDeletion();
});
UINewline();
UIButton("game_end()", function()
{
    game_end();
});