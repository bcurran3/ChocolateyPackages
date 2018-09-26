<img src="https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/InstChoco/InstChoco_icon.png" width="139" height="88">

**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original!
* Read the INSTALL EXAMPLES again before use!
* I personally use and endorse this package/task.

#DO YOU WANT TO UPGRADE YOUR CHOCOLATEY PACKAGES EVERY DAY? OR MAYBE EVERY WEEK?

#YOU JUST FOUND THE EASY WAY!
	
###This package creates a Windows Scheduled Task to run "choco upgrade all -y" at a time and frequency you specify. And because sometimes package installations go wrong... it will also create a Windows Scheduled Task to run "taskkill /im choco.exe /f /t" to stop the Chocolatey (choco.exe) process and all child processes at a time you specify.

This package is a pseudo replacement for [choco-upgrade-all-at-startup](https://chocolatey.org/packages/choco-upgrade-all-at-startup).

###INSTRUCTIONS:
You can install **choco-upgrade-all-at** with multiple parameters to make it run "choco upgrade all -y" daily or weekly (Monthly is just not often enough!) at your preferred time. If you enter no parameters at all, **choco-upgrade-all-at** will default to run "choco upgrade all -y" at 2 AM every day and abort the process at 4 AM. When entering the TIME and ABORTTIME parameters, use "[Military Time](http://militarytimechart.com/)." When entering the DAILY or WEEKLY parameter you can actually use anything, "yes" just makes sense though. When using the WEEKLY parameter, DAYS are entered as MON, TUE, WED, THU, FRI, SAT, or SUN. Not entering the correct format will fail the install. Please see the examples below.

###INSTALL EXAMPLES:
* **choco install choco-upgrade-all-at --params "'/TIME:23:00'"** - runs "choco upgrade all -y" daily (default) at 11 PM and aborts at 4 AM, technically 19 hours earlier but will also result in 5 hours later.
* **choco install choco-upgrade-all-at --params "'/DAILY:yes /TIME:04:00 /ABORTTIME:08:00'"** - runs "choco upgrade all -y" daily at 4 AM and aborts it at 8 AM.
* **choco install choco-upgrade-all-at --params "'/WEEKLY:yes /DAY:SUN /TIME:01:00'"** - runs "choco upgrade all -y" every Sunday at 1 AM and aborts at 4 AM.

####A NOTE ON DEFAULTS:
* If you don't specify any parameters, **choco-upgrade-all-at** defaults to running daily at 2AM and aborting at 4 AM. (My preference!) 
* Not specifying a TIME will always default to 2 AM. Not specifying an ABORTTIME will always default to 4 AM. If you're setting a TIME, be sure to also set the ABORTTIME.
* When WEEKLY is specified but a DAY isn't, default first run will be a week from installation date; i.e. next week on whatever day of the week you installed the package.

####IF UPGRADING FROM A VERSION EARLIER THAN 0.0.4:
* Your old scheduled task will be deleted and replaced with default (mentioned above) parameters. To ensure **choco-upgrade-all-at** runs when you want it to, you should uninstall and reinstall with the settings you prefer.
* I have not tested with useRememberedArgumentsForUpgrades, you might get daily still with your preferred time.

####IF UPGRADING FROM VERSION 0.0.4 or 0.0.4.1:
* You're old scheduled task will be kept. You will need to uninstall and re-install to take advantage of the new ABORTTIME feature.

CHANGELOG:
* 0.0.5   - Added abort stuck upgrades feature. "Um, why do I want this?" you're thinking. You want this because sometimes background package installations go wrong. "Go wrong?" you're thinking. Yes, there are a couple scenarios where a Chocolatey package installation/upgrade can hang: if a package needs input, if an AutoHotKey or AutoIt script fails, and all those times a program installer pops up a browser window to tell you "Thank you." These scenarios leave hung processes in the background with no way for you to easily interact with them (They're in the background!). This means they are taking up memory resources for no reason and might cause problems installing other packages or programs. **If** you knew there was a hung process, you could manually stop the task, but who wants to check every day? This will automate checking and stopping any Chocolatey package hung tasks at the time you specify. I recommend setting it to a time an hour or two after you run your updates. 
* 0.0.4.1 - Fixed compatibility with Windows 7 & 8 machines by using SchTasks.exe for everything and not using the Windows 10/Server 2016 only get-scheduledtask cmdlet. Removed PowerShell v4/v5 dependency. 
* 0.0.4   - Added option to run weekly.


***

Like my [original Chocolatey add-ons and packages](https://chocolatey.org/search?q=tag%3Abcurran3)? or my [400+ other program packages](https://chocolatey.org/profiles/bcurran3)? Find them useful? Appreciate my hard work, time, and effort?


<h1>How about buying me a <img src="https://cdn.rawgit.com/bcurran3/ChocolateyPackages/master/mylogos/beer.png" alt="" width="40" height="40"> via PayPal?</h1>

[![PayPal Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

<h1>Better yet... Keep me incentivized by Patreonizing me!</h1>

[![Patreonize me!](https://c5.patreon.com/external/logo/downloads_wordmark_white_on_coral.png)](https://www.patreon.com/bcurran3)


If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Bill</h3>