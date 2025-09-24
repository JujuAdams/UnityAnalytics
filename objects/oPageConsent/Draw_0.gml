UIStart(10, 10);
UIText("Unity Analytics " + UA_VERSION);
UINewline();
UIButton("Consent to analytics", function()
{
    UASetUserConsent(true);
    instance_destroy();
    instance_create_depth(0, 0, 0, oPageTest);
});
UINewline();
UIButton("Decline analytics", function()
{
    UASetUserConsent(false);
    instance_destroy();
    instance_create_depth(0, 0, 0, oPageTest);
});