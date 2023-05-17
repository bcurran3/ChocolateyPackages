<img src="https://cdn.staticaly.com/gh/bcurran3/ChocolateyPackages/master/mylogos/myunofficialChocolateylogo_icon.png" width="139" height="88">

![screenshot of choco-protocol-support](https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/choco-protocol-support/choco-protocol-support_screenshot.png)	
	
# Implements installing of Chocolatey packages from the web using choco:// Protocol.

### WHO IS THIS FOR?
**choco-protocol-support** is designed for those who aren't comfortable with the Command Prompt or just don't like to type much. **choco-protocol-support** allows you to install Chocolatey packages by simply clicking choco:// URLs in your web browser. **choco-protocol-support** is also useful for support professionals who know the difficulty of getting end users to type in commands correctly. Now you can give end users a URL via e-mail or corporate software webpage to click and have a Chocolatey package installed!

If you like the convienance of this package, you should also check out [Install Chocolatey Packages from your Web Browser](https://chocolatey.org/packages/choco-install-packages-from-web-winconfig) which is very similar in concept as well as [(unofficial) Chocolatey Shortcuts (Config)](https://chocolatey.org/packages/choco-shortcuts-winconfig). All three of these make installing Chocolatey packages very user friendly.

### HOW DOES IT WORK?
**choco-protocol-support** configures Windows to use choco://packagename URLs and pass them along to **choco-protocol-support.ps1** which then processes the URL and runs "choco install" or "choco upgrade" to install or upgrade the package. [This ability will be baked natively into a future version of Chocolatey](https://github.com/chocolatey/choco/issues/1680) and then this package can be retired.

### USAGE INSTRUCTIONS:
Just click a choco://packagename URL on a web page and the package will install after one or two approval clicks. 
Browser examples: [Chrome](https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/choco-protocol-support/choco-protocol-support_chrome_example.png) | [Firefox](https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/choco-protocol-support/choco-protocol-support_firefox_example.png) | [Opera](https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/choco-protocol-support/choco-protocol-support_opera_example.png)

### **Easy peasy, Chocolateasy!**

### INTRODUCING THE FIRST choco:// URLS ON THE INTERNET:
(AKA Other fine 3rd party Chocolatey utilities by BCURRAN3)
[choco://instchoco](choco://instchoco) - (unofficial) InstChoco - The ULTIMATE Chocolatey and Chocolatey packages (re)installer!
[choco://choco-package-list-backup](choco://choco-package-list-backup) - (unofficial) Choco Package List Backup to Local and Cloud
[choco://choco-cleaner](choco://choco-cleaner) - (unofficial) Choco Cleaner
[choco://choco-upgrade-all-at](choco://choco-upgrade-all-at) - (unofficial) Choco Upgrade All at
[choco://choco-shortcuts-winconfig](choco://choco-shortcuts-winconfig) - (unofficial) Chocolatey Shortcuts 
[choco://chocolatey-toast-notifications.extension](choco://chocolatey-toast-notifications.extension) - (unofficial) Chocolatey Toast Notifications 
[choco://chocolatey-preinstaller-checks.extension](choco://chocolatey-preinstaller-checks.extension) - (unofficial) Chocolatey Preinstaller Checks
[choco://choco-install-packages-from-web-winconfig](choco://choco-install-packages-from-web-winconfig) - (unofficial) Install Chocolatey Packages from your Web Browser 

#### WARNING: Only install one package at a time until such time as Chocolatey is multi-instance aware or it will corrupt itself. [(REFERENCE)](https://github.com/chocolatey/choco/issues/1579)

### Sounds cool but where can I use it now?
You can install any Chocolatey package from the [Chocolatey Community Repository website](https://community.chocolatey.org/packages) using Chrome with the help of BananaAcid's [Chocolatey Appstore Theme for Chrome (unofficial)](https://community.chocolatey.org/packages/chocolatey-appstore-chrome)! [Chrome Web Store direct link](https://chrome.google.com/webstore/detail/chocolatey-appstore/gkehnkphfligaeniienfamgdfocegffl)

### CHANGELOG:
* 0.2     - Rewritten in PowerShell, changed use of cinst.exe to choco.exe (install) for Chocolatey v2 compatibility, sudo dependency removed as no longer needed, added version support, now checks for the package and uses choco upgrade instead of choco install when appropriate
* 0.0.1.1 - Removed Chocolatey dependency as Chocolatey v1.0 has been released and missed the [1.x milestone](https://github.com/chocolatey/choco/milestone/12) of becoming multi-instance aware and no new known goal. Added [gsudo](https://community.chocolatey.org/packages/gsudo) support.
* 0.0.1   - Initial release.

### ROADMAP:
* Add parameters, install arguments, and source support (Going to need a LOT of difficult parsing for escaping!)
* Add a config file that allows setting of default parameters, install arguments, source, etc.
* Error checking for malformed URLs (Low priority, this resposibility should fall on the webmaster.)
* Theoretically it's possible to add all choco install options and switches, but why?

***

Like my [original Chocolatey add-ons and packages](https://community.chocolatey.org/packages?q=tag%3Abcurran3)? or my [400+ other program packages](https://chocolatey.org/profiles/bcurran3)? Find them useful? Appreciate my hard work, time, and effort?


<h1>How about buying me a <img src="https://cdn.rawgit.com/bcurran3/ChocolateyPackages/master/mylogos/beer.png" alt="" width="40" height="40"> via PayPal?</h1>

[![PayPal Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

<h1>Better yet... Keep me incentivized by Patreonizing me!</h1>

[![Patreonize me!](https://c5.patreon.com/external/logo/downloads_wordmark_white_on_coral.png)](https://www.patreon.com/bcurran3)


If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Bill</h3>