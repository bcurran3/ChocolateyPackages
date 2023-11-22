<img src="https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/choco-continuous-upgrader/choco-continuous-upgrader_icon.png" width="200" height="200">

**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original! So of course I endorse and use it. :)
* I'm open to suggestions - open a GitHub issue please.

---

### [choco://choco-continuous-upgrader](choco://choco-continuous-upgrader)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://community.chocolatey.org/packages/choco-protocol-support)

---

![Screenshot of choco-continuous-upgrader](https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/choco-continuous-upgrader/choco-continuous-upgrader_screenshot.png)
[Click here for secret GeekMode screenshot](https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/choco-continuous-upgrader/choco-continuous-upgrader_geekmodescreenshot.png)

This package is a pseudo replacement for [choco-upgrade-all-at](https://chocolatey.org/packages/choco-upgrade-all-at) which is a pseudo replacement for [choco-upgrade-all-at-startup](https://chocolatey.org/packages/choco-upgrade-all-at-startup). (Got that? There will be a pop quiz!) **CCU** is a result of my obsessive desire to keep my Chocolatey packages up-to-date.

# DO YOU WANT TO UPGRADE YOUR CHOCOLATEY PACKAGES CONTINUOUSLY THROUGHOUT THE DAY?

# YOU JUST FOUND THE EASY WAY!
	
# HOW DOES IT WORK?

**CCU** starts a background PowerShell process which continuously checks [FeedBurner](https://feeds.feedburner.com/chocolatey) for recently published Chocolatey packages. When locally installed packages are found in the feed, they are automatically upgraded.

**CCU** defaults to checking every 30 minutes, automatically upgrading packages, and no foreground notifications. These defaults are overridable and configurable; e.g. you could use **CCU** to just notify you of upgrades without automatically installing them.

### HIGHLY RECOMMENDED:
Install my [choco-toast-notifications.hook](https://community.chocolatey.org/packages/choco-toast-notifications.hook) to enable beautiful foreground toast notifications of package installs, upgrades, and uninstalls. If you plan to use **CCU** only for notifications of upgrades without having them automatically installed, I recommend using [burnttoast-psmodule](https://community.chocolatey.org/packages/burnttoast-psmodule) for those notifications.

### USAGE INSTRUCTIONS:
**CCU -Start** will start **CCU** with defaults.
**CCU -Status** will display **CCU**'s running options and packages that have been upgraded or waiting to be upgraded.
**CCU -Notify** (assumes -Start) will send foreground notifications of upgrades using either BurntToast or MSG.
**CCU -NoUpgrades** (assumes -Start) will check for upgrades but not automatically install them.
**CCU -Stop** to stop **CCU**.
**CCU -EditConfig** to set your custom defaults.
**CCU -Help** for more info.

### CHANGELOG:
* 1.0.0 - initial release

### ROADMAP
* - Nothing planned.
* - Maybe, just maybe... only if I'm really bored one day or people demand it, setup a scheduled task to auto-run CCU on system boot.
* - It would be neat to make a tray app that replicates GeekMode...

***

Like my [original Chocolatey add-ons and packages](https://community.chocolatey.org/packages?q=tag%3Abcurran3)? or my [400+ other program packages](https://chocolatey.org/profiles/bcurran3)? Find them useful? Appreciate my hard work, time, and effort?


<h1>How about buying me a <img src="https://cdn.rawgit.com/bcurran3/ChocolateyPackages/master/mylogos/beer.png" alt="" width="40" height="40"> via PayPal?</h1>

[![PayPal Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

<h1>Better yet... Keep me incentivized by Patreonizing me!</h1>

[![Patreonize me!](https://c5.patreon.com/external/logo/downloads_wordmark_white_on_coral.png)](https://www.patreon.com/bcurran3)


If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Bill</h3>
