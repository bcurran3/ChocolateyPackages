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

CHANGE LOG:
* 0.0.1   - initial release

ROADMAP:
* Check for the Chocolatey self service agent and handle differently (ignore?) when found.
* Possibly add configurable options to enable disable each of the three checks.
* Probably add configurable timeouts for each of the three checks.
* Probably add conditional handling options for each of the three checks, i.e. option to abort install based on condition.

You can add your options/wants/recommendations to https://github.com/bcurran3/ChocolateyPackages/issues/27

Like my [packages](https://chocolatey.org/profiles/bcurran3)? 

Find them useful?

**Want to buy me a beer?**

[![Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

If applicable, please always consider donating to the developer or purchasing the software first - this includes [Chocolatey licensed editions](https://chocolatey.org/pricing).



