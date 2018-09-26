<img src="https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/mylogos/myunofficialChocolateylogo_icon.png" width="139" height="88">

**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original!
* I personally use and endorse this extension.

**chocolatey-misc-helpers.extension** provides helper functions to be used in Chocolatey install/uninstall scripts by package creators/maintainers. 

These didn't fit into the concept scope of my other extensions so I decided to start a new miscellaneous collection and will add to it as "needed."

###HELPERS:
* **Start-CheckandStop** - Checks for and stops a process if running. Creates variables to easily restart the process after a package upgrade. Useful for installers that fail if the program is running, i.e. KeePass, uTorrent, etc. or for stopping programs that automatically run after install, i.e. Skype, SuMo, Ellp, etc. as well as for programs that will stop running during an upgrade and then not return to a running state post upgrade, i.e. Plex Media Server, etc.
* **Show-ToastMessage** - Displays a Windows [toast](https://en.wikipedia.org/wiki/Windows_Push_Notification_Service) message, you can send two lines. (Currently requires [BurntToast PS module](https://github.com/Windos/BurntToast) pre-installed.) [SCREENSHOT](https://cdn.rawgit.com/bcurran3/ChocolateyPackages/master/chocolatey-misc-helpers.extension/chocolatey-misc-helpers.extension_screenshot.png)
* **Start-WaitandStop** - starts a background process to stop a (foreground) process - quits after 5 minutes or after the process gets stopped. Useful to stop additional pop-up programs during installation. 
* **Start-WaitandStopActual** - (do not directly use) called by Start-WaitandStop to make Start-WaitandStop simple to use.
* **Read comments in the scripts for help implementing.**

***
DO NOT USE: Added but later nullified. Inclusion for backward compatibility with pre-release versions in the wild.
* **Show-Patreon** - Displays a message and link to your [Patreon](https://www.patreon.com/) website.
* **Show-PayPal** - Displays a message and link to your [PayPal](https://www.paypal.com/) website.
***

###USAGE:
* Show-ToastMessage "Your message line 1" "Your message line 2"
* Start-CheckandStop "ProcessName"
* Start-WaitandStop "ProcessName"

CHANGE LOG:
###CHANGE LOG:
* 0.0.2 - Show-ToastMessage added (neutered from original form), Show-Patreon and Show-PayPal added but disapproved by the Chocolatey team and thus nullified. :(
* 0.0.1 - initial release

***

Like my [original Chocolatey add-ons and packages](https://chocolatey.org/search?q=tag%3Abcurran3)? or my [400+ other program packages](https://chocolatey.org/profiles/bcurran3)? Find them useful? Appreciate my hard work, time, and effort?


<h1>How about buying me a <img src="https://cdn.rawgit.com/bcurran3/ChocolateyPackages/master/mylogos/beer.png" alt="" width="40" height="40"> via PayPal?</h1>

[![PayPal Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

<h1>Better yet... Keep me incentivized by Patreonizing me!</h1>

[![Patreonize me!](https://c5.patreon.com/external/logo/downloads_wordmark_white_on_coral.png)](https://www.patreon.com/bcurran3)


If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Bill</h3>




