<<<<<<< HEAD
<img src="https://cdn.staticaly.com/gh/bcurran3/ChocolateyPackages/master/mylogos/myunofficialChocolateylogo_icon.png" width="139" height="88">

**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original!
* I personally use and endorse this extension.

***
[choco://choco-nuspec-checker](choco://choco-nuspec-checker)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://chocolatey.org/packages/choco-protocol-support)
***
	
![Screenshot of (unofficial) Chocolatey .nuspec Checker (Script)](https://cdn.staticaly.com/gh/bcurran3/ChocolateyPackages/master/choco-nuspec-checker/choco-nuspec-checker_screenshot.png)

#**choco-nuspec-checker** (**CNC**) is a PowerShell script designed for Chocolatey package maintainers/creators to check Chocolatey .nuspec files for common errors and ommisions. Find out what the Chocolatey validator is going to tell you BEFORE you submit your package. 

###FEATURES:
* **CNC** checks for common verifier guidelines, suggestions, and notes warnings
* **CNC** checks for all tags and reports if any are missing
* **CNC** checks for dead URLs and reports them
* **CNC** checks for GitHub direct links, reports them, and can convert to Staticaly CDN URLs
* **CNC** checks for RawGit CDN links, reports them, and can convert to Staticaly CDN URLs
* **CNC** can open all your .nuspec element URLs in your default browser for quick viewing
* **CNC** can add a standard template header and/or footer to your .nuspec description (coming soon)

###Helps make packaging Chocolateasy!

###INSTRUCTIONS:
* Change to the directory where you have a package .nuspec file and run **CNC** via PowerShell; it's already in your path. **CNC -help** for help and options. 
* To check all your packages' .nuspec files change to the root directory of all your packages and via PowerShell run **Get-ChildItem -Recurse | ?{if ($__.PSIsContainer){cls;cd $__.Name;cnc;cd ..;pause}}**

**[PACKAGE NOTES](https://github.com/bcurran3/ChocolateyPackages/blob/master/choco-nuspec-checker/readme.md)**

**If you find choco-nuspec-checker useful please consider donating: https://www.paypal.me/bcurran3donations or become a patron at https://www.patreon.com/bcurran3**

###CHANGELOG:
* 2019.01.12 - minor fixes
* 2019.01.09 - many more checks and warnings added, almost all known verifier guidelines, suggestions and notes added, some beautifications, added option to view Chocolatey validator info page, added optional image GitHub direct and RawGit URL conversions to Staticaly CDN URLs
* 2019.01.07 - added help, added option to open and view all URLs in your default browser, added options to view, edit, and add "standard" (template) headers and footers to the description (can't save yet), added reporting of standard header and footer if found, added more verifier messages, added checking for descriptions that are too large (>4,000), now checks for license files other than LICENSE.txt, probably more I don't remember :)
* 2019.01.04 - implemented included binary files checking and messages, laid out the groundwork for the future enhancements
* 2019.01.03 - fixed some URL checking handling that could cause PS errors, updated list of CDN recommendations, added checking for RawGit URLs in description, cosmetic updates
* 2018.12.22-2018-12.28 - initial release

###ROADMAP:
* take a filespec to check .nuspec files outside of the local path
* automatically convert RawGit CDN URLs to Staticaly or a possibly a selectable preference
* (out of original scope) option to insert configurable headers and footers into description (some groundwork laid)
* capture and test URLs found in description

***

Like my [original Chocolatey add-ons and packages](https://chocolatey.org/search?q=tag%3Abcurran3)? or my [400+ other program packages](https://chocolatey.org/profiles/bcurran3)? Find them useful? Appreciate my hard work, time, and effort?


<h1>How about buying me a <img src="https://cdn.rawgit.com/bcurran3/ChocolateyPackages/master/mylogos/beer.png" alt="" width="40" height="40"> via PayPal?</h1>

[![PayPal Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

<h1>Better yet... Keep me incentivized by Patreonizing me!</h1>

[![Patreonize me!](https://c5.patreon.com/external/logo/downloads_wordmark_white_on_coral.png)](https://www.patreon.com/bcurran3)


If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Bill</h3>




=======
<img src="https://cdn.staticaly.com/gh/bcurran3/ChocolateyPackages/master/InstChoco/InstChoco_icon.png" width="139" height="88">

**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original!
* I personally use and endorse this extension.

![Screenshot of Chocolatey Toast Notifications Extension](https://cdn.staticaly.com/gh/bcurran3/ChocolateyPackages/master/chocolatey-toast-notifications.extension_extras/chocolatey-toast-notifications.extension_screenshot.png)

###It's HERE! The 100% Chocolatey user OPT-IN toast notification extension for Chocolatey and Windows 10 (only).

##**Chocolatey Toast Notifications Extension** is a Chocolatey extension that displays a toast notification after installing or uninstalling a program. This extension will start working automatically once installed and does NOT need to be implemented by package creators/maintainers. **Chocolatey Toast Notifications Extension** is meant to be installed and used directly by Chocolatey end users.

###PURPOSE:

* Chocogeeky fun!

###FEATURES: 
* **Chocolatey Toast Notifications Extension** will display a toast notification with the package name, program name, program version, status message (installed or uninstalled), and a link to the package page on the chocolatey.org website after a program is installed or uninstalled.

###WHAT IT WON'T DO:
* **Chocolatey Toast Notifications Extension** will NOT work on anything other than Windows 10, this is a limitation of the [BurntToast](https://github.com/Windos/BurntToast) PowerShell module and its use of the [UWP Community Toolkit](https://github.com/Microsoft/WindowsCommunityToolkit). (Yes, I tried it on Windows Server 2016 and it did NOT work.)
* **Chocolatey Toast Notifications Extension** will NOT display messages for programs that don't use standard installers, i.e. portable programs.
* **Chocolatey Toast Notifications Extension** will NOT display messages for programs installed/uninstalled via any background processes; i.e. my **[choco-upgrade-all-at-startup](https://chocolatey.org/packages/choco-upgrade-all-at-startup)**, **[choco-upgrade-all-at](https://chocolatey.org/packages/choco-upgrade-all-at)**, and **[choco-persistent-packages](https://chocolatey.org/packages/choco-persistent-packages)** packages... YET!

**[PACKAGE NOTES](https://github.com/bcurran3/ChocolateyPackages/blob/master/chocolatey-toast-notifications.extension/readme.md)**

***
**Click here to [Patreon-ize](https://www.patreon.com/bcurran3) the package maintainer.**
***

###CHANGE LOG:
* 0.0.3 - Notifications will now display in the foreground when sent from a background task using the system account.
* 0.0.2 - baked in compatibility with [chocolatey-preinstaller-checks.extension](https://chocolatey.org/packages/chocolatey-preinstaller-checks.extension) if installed
* 0.0.1 - initial release

###ROADMAP:
* Possibly make it Windows 8 compatible after packaging up an old version of [BurntToast](https://github.com/Windos/BurntToast)
* Possibly make it Windows Server 2016 compatible.
* Attempt to make it work with PORTABLE packages as well.

***

Like my [original Chocolatey add-ons and packages](https://chocolatey.org/search?q=tag%3Abcurran3)? or my [400+ other program packages](https://chocolatey.org/profiles/bcurran3)? Find them useful? Appreciate my hard work, time, and effort?


<h1>How about buying me a <img src="https://cdn.rawgit.com/bcurran3/ChocolateyPackages/master/mylogos/beer.png" alt="" width="40" height="40"> via PayPal?</h1>

[![PayPal Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

<h1>Better yet... Keep me incentivized by Patreonizing me!</h1>

[![Patreonize me!](https://c5.patreon.com/external/logo/downloads_wordmark_white_on_coral.png)](https://www.patreon.com/bcurran3)


If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Bill</h3>




>>>>>>> 27f72bd1d91c65406d60ff1baab58075e1892b75