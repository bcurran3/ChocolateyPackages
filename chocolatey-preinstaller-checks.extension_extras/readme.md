<img src="https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/InstChoco/InstChoco_icon.png" width="139" height="88">

**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original!
* I personally use and endorse this extension.
* The choco multi-instance checking is NOT compatible with the Chocolatey licensed self service agent as it runs choco.exe all the time.

![Screenshot of chocolatey-preinstaller-checks.extension](https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/chocolatey-preinstaller-checks.extension/chocolatey-preinstaller-checks.extension_screenshot.png)

##**Chocolatey Preinstaller Checks Extension** is a Chocolatey extension that intercepts and runs checks before installing or uninstalling a program. This extension will start working automatically once installed and does NOT need to be implemented by package creators/maintainers. **Chocolatey Preinstaller Checks Extension** is meant to be installed and used directly by Chocolatey end users.

###PURPOSE:

This extension attempts to head off problems related to:

* [https://github.com/chocolatey/choco/issues/544](https://github.com/chocolatey/choco/issues/544)
* [https://github.com/chocolatey/choco/issues/619](https://github.com/chocolatey/choco/issues/619)
* [https://github.com/chocolatey/choco/issues/761](https://github.com/chocolatey/choco/issues/761)
* [https://github.com/chocolatey/choco/issues/780](https://github.com/chocolatey/choco/issues/780)
* [https://github.com/chocolatey/choco/issues/1526](https://github.com/chocolatey/choco/issues/1526)
* [https://github.com/chocolatey/choco/issues/1548](https://github.com/chocolatey/choco/issues/1548)
* [https://github.com/chocolatey/choco/issues/1579](https://github.com/chocolatey/choco/issues/1579)
* and possibly others until such time that Chocolatey natively handles these issues better and this extension becomes moot.

**Chocolatey Preinstaller Checks Extension**'s main purpose is to fend off specific types of problems before they occur. Currently Chocolatey (choco.exe) is not multi-instance friendly. If you try to install or uninstall packages using choco.exe in two Command Prompts at the same time, strange (bad) things may occur. **Chocolatey Preinstaller Checks Extension** avoids these strange (bad) things by intercepting calls to install and uninstall programs and making the current choco.exe instance wait for previous instances to finish. **Chocolatey Preinstaller Checks Extension** also checks Windows Installer to see if it's busy and will make MSI installer and uninstaller programs wait until Windows Installer has finished processing the other program. **Chocolatey Preinstaller Checks Extension** will pause and retry until [commandExecutionTimeoutSeconds](https://chocolatey.org/docs/chocolatey-configuration) hits it's threshold and then choco will abort. **Chocolatey Preinstaller Checks Extension** only runs before PROGRAM installations and uninstallations. It does not perform any functions related to portable packages or other choco commands.

###FEATURES: 
* **Chocolatey Preinstaller Checks Extension** will check if there is a pending reboot and warn you about it if so.
* **Chocolatey Preinstaller Checks Extension** will check if there are instances of choco.exe already running and wait for them to finish.
* **Chocolatey Preinstaller Checks Extension** will check if Windows Installer is already running and wait for it to finish.

* The choco multi-instance checking is supposedly NOT compatible with the Chocolatey licensed self service agent as it supposedly runs choco.exe all the time.
* If two instances of choco.exe run within 30 seconds of each other, they will most likely loop forever or at least until [commandExecutionTimeoutSeconds](https://chocolatey.org/docs/chocolatey-configuration).
* Aborting a program package install/uninstall due to "* WARNING: x other instance(s) of choco.exe actual found running. Pausing 30 seconds..." will result in Chocolatey "loosing" the package, i.e. "[Pending] Removing incomplete install for 'packagename'" on next run. The result is the same if you have this extension or not and defeats the purpose of this extension.

###CHANGE LOG:
* 0.0.2 - Added configurable options to only warn or pause and retry when multiple instances are found. Added configurable pause time for each of the multiple instance checks. Added conditional handling options for each of the three checks, i.e. option to abort install based on condition. Edit C:\ProgramData\chocolatey\lib\chocolatey-preinstaller-checks.extension\Chocolatey-Preinstaller-Checks.xml. To warn only set WaitOnMultiple to false (default true). To abort install/uninstall when there is a problem set AbortOnMultiples to true (default false).
* 0.0.1 - initial release

ROADMAP:
* Check for the Chocolatey self service agent and handle differently (ignore?) when found.
* Possibly add configurable options to enable disable each of the three checks.
* Probably add configurable timeouts for each of the three checks.
* Probably add conditional handling options for each of the three checks, i.e. option to abort install based on condition.

You can add your options/wants/recommendations to https://github.com/bcurran3/ChocolateyPackages/issues/27

***

Like my [original Chocolatey add-ons and packages](https://chocolatey.org/search?q=tag%3Abcurran3)? or my [400+ other program packages](https://chocolatey.org/profiles/bcurran3)? Find them useful? Appreciate my hard work, time, and effort?


<h1>How about buying me a <img src="https://cdn.rawgit.com/bcurran3/ChocolateyPackages/master/mylogos/beer.png" alt="" width="40" height="40"> via PayPal?</h1>

[![PayPal Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

<h1>Better yet... Keep me incentivized by Patreonizing me!</h1>

[![Patreonize me!](https://c5.patreon.com/external/logo/downloads_wordmark_white_on_coral.png)](https://www.patreon.com/bcurran3)


If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Bill</h3>




