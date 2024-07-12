<h1 align="center">UnityAnalytics 2.0.1</h1>

<p align="center">Unity Analytics but for GameMaker</p>

<p align="center"><a href="https://github.com/JujuAdams/UnityAnalytics/releases/">Download the .yymps</a></p>

&nbsp;

## Quick Start

 1. Register a Unity services account and create an analytics project.
 2. Obtain the project ID (a hexadecimal string) and environment ID (usually "production").
 3. Import the Unity Analytics .yymps into your project.
 4. Open `__UAConfig` and adjust `UA_PROJECT_ID` and `UA_ENVIRONMENT_ID`.
 5. Execute the following code on boot:
     ```gml
     UASetUserID(UAEnsureUserID("analyticsUserID.dat"));
     UASetUserConsent(true);
     ```
 6. Run your game on Windows, MacOS, or Linux. The library will automatically send a "gameStarted" event to UA.
 7. Wait 5 minutes then check the Unity Analytics event browser. You should see a valid "gameStarted" event appear.
 8. Define some custom events in the UA backend. Call `UAEvent()` in your code to match these custom events.
 9. Set `UA_DEBUG_LEVEL` to 1 or 2 to help with debugging. Run the game and check events are being triggered properly.
 9. Wait 5 minutes then check the event browser to confirm your custom events have been received.
10. Remove the `UASetUserConsent()` call on boot and build a user consent flow for analytics in your game.

And you're done! Please read comments in the library's functions (there aren't many) to learn about advanced use. This library **should** work on every platform that allows outgoing HTTP requests but has only been tested on desktop and mobile.
