<img src="https://cdn.staticaly.com/gh/bcurran3/ChocolateyPackages/master/mylogos/myunofficialChocolateylogo_icon.png" width="139" height="88">

**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original!
* I personally use and endorse this script.

***
### [choco://choco-package-deprecater](choco://choco-package-deprecater)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://chocolatey.org/packages/choco-protocol-support)
***
	
![Screenshot of (unofficial) Chocolatey Package Deprecater/Retirer (Script)](https://cdn.staticaly.com/gh/bcurran3/ChocolateyPackages/master/choco-package-deprecater/choco-package-deprecater_screenshot.png)

## **choco-package-deprecater** (**CDEPRECATE**) is a PowerShell script I designed for Chocolatey package maintainers/creators to easily deprecate or retire a package. Probably not something you have to do often but **CDEPRECATE** will save you the time of having to look up what you need to do to your .nuspec file.

### FEATURES:
* **CDEPRECATE** rewrites a .nuspec file modifying it ready for deprecation or retirement.
* **CDEPRECATE** backups up your original .nuspec file, always!
* **CDEPRECATE** will create the necessary chocolateyInstall.ps1 for retired packages.
* **CDEPRECATE** can add a "cute" iconUrl.

### Helps make packaging Chocolateasy!

### INSTRUCTIONS:
* **CDEPRECATE -help** for help with options and switches

**[PACKAGE NOTES](https://github.com/bcurran3/ChocolateyPackages/blob/master/choco-package-deprecater/readme.md)**

### CHANGELOG:
* 2022.03.15 - Updated messages with markdown that are incompatible with the Sept. 2019 changes to chocolatey.org, set requireLicenseAcceptance to false to avoid schema error (new behavior?), -addicon will now work if iconUrl was originally blank; changed iconUrl to use CDN URLs, now won't add [DEPRECATED] or [RETIRED] if you run cdeprecate a 2nd time, implemented a config file and defaults, now removes "shim" when uninstalled, updated Chocolatey's DEPRECATE A PACKAGE URL
* 2019.09.03 - initial release. Does most of what's needed. Finishing touches and improvements to come. MIWMIP - "Make it work. Make it pretty."

***

Like my [original Chocolatey add-ons and packages](https://community.chocolatey.org/packages?q=tag%3Abcurran3)? or my [400+ other program packages](https://chocolatey.org/profiles/bcurran3)? Find them useful? Appreciate my hard work, time, and effort?


<h1>How about buying me a <img src="https://cdn.rawgit.com/bcurran3/ChocolateyPackages/master/mylogos/beer.png" alt="" width="40" height="40"> via PayPal?</h1>

[![PayPal Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

<h1>Better yet... Keep me incentivized by Patreonizing me!</h1>

[![Patreonize me!](https://c5.patreon.com/external/logo/downloads_wordmark_white_on_coral.png)](https://www.patreon.com/bcurran3)


If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Bill</h3>
