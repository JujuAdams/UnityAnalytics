// Feather disable all

UIStart(10, 10);
UIText("Unity Analytics " + UA_VERSION);
UINewline();
UIButton("Set using ensured user ID", function()
{
    UASetUserID(UAEnsureUserID("ua.dat"));
    instance_destroy();
    instance_create_depth(0, 0, 0, oPageConsent);
});
UINewline();
UIButton("Set \"User A\" as user ID", function()
{
    UASetUserID("User A");
    instance_destroy();
    instance_create_depth(0, 0, 0, oPageConsent);
});
UINewline();
UIButton("Set \"User B\" as user ID", function()
{
    UASetUserID("User B");
    instance_destroy();
    instance_create_depth(0, 0, 0, oPageConsent);
});
UINewline();
UIButton("Send test event\n(should be queued until user is set)", function()
{
    UAEvent("jujusCustomEvent", {
        jujusTestParameter: 42,
    });
});