<img src="https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/mylogos/myunofficialChocolateylogo_icon.png" width="139" height="88">

**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original!
* I personally use and endorse this extension.

**chocolatey-misc-helpers.extension** provides helper functions to be used in Chocolatey install/uninstall scripts by package creators/maintainers. 

These didn't fit into the concept scope of my other extensions so I decided to start a new miscellaneous collection and will add to it as "needed."

###HELPERS:
* **Start-CheckandStop** - checks for and stops a process if running. Also creates variables to easily restart the process after a package upgrade. Useful for installers that fail if the program is running. Read comments in the script to implement.
* **Start-WaitandStop** - starts a background process to stop a (foreground) process - quits after 5 minutes or after the process gets stopped. Useful to stop additional pop-up programs during installation. This would usually be called before Install-ChocolateyPackage.
* **Start-WaitandStopActual** - (do not directly use) called by Start-WaitandStop to make Start-WaitandStop simple to use.

###USAGE:
* Start-CheckandStop "ProcessName"
* Start-WaitandStop "ProcessName"

CHANGE LOG:
* 0.0.1   - initial release. If you installed before 06/20/2018 final, please force reinstall.


***

Like my [original Chocolatey add-ons and packages](https://chocolatey.org/search?q=tag%3Abcurran3)? or my [400+ other program packages](https://chocolatey.org/profiles/bcurran3)? Find them useful? Appreciate my hard work, time, and effort?


<h1>How about buying me a <img src="https://cdn.rawgit.com/bcurran3/ChocolateyPackages/master/mylogos/beer.png" alt="" width="40" height="40"> via PayPal?</h1>

[![PayPal Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

<h1>Better yet... Keep me incentivized by Patreonizing me!</h1>

[![Patreonize me!](https://c5.patreon.com/external/logo/downloads_wordmark_white_on_coral.png)](https://www.patreon.com/bcurran3)


If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Bill</h3>