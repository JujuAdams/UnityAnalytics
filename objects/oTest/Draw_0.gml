UIStart(10, 10);
UIText("Unity Analytics " + __UA_VERSION);
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