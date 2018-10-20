<h3>BCURRAN3'S PACKAGE NOTES:</h3>

* The download URL in this package will always download the latest version. Versions of the program released after this package will fail checksums. If you get an error installing this package please try --ignore-checksums and open a GitHub Issue requesting the package to be updated.
* To automated this package, it is installed with the install --root option thus skipping creating a new user. When you run WSL you will be logged in as root. To create a user use the adduser command.
* There are a lot of comments about this in the ChocolateyInstall script. You can view them on the chocolatey.org package page.
* I'm told installing via the Microsoft Store creates a Windows Start Menu icon, this package does not. Run from an elevated CLI.
* If you encounter errors such as Error: 0x80070005 Press any key to continue... it usually means that WSL has lost track of the distro files (they might have moved or been deleted.) You should uninstall the package. If the package is missing you can list your installed distros with wslconfig /list, remove the distro with wslconfig /unregister distroname, then simply reinstall the package.
* Future upgrades are a mystery. It's probably best to pin this package as an upgrade might wipe out your rootfs folder and anything you've saved or upgraded in there. Pin help here: https://github.com/chocolatey/choco/wiki/CommandsPin

***

Like my [original Chocolatey add-ons and packages](https://chocolatey.org/search?q=tag%3Abcurran3)? or my [400+ other program packages](https://chocolatey.org/profiles/bcurran3)? Find them useful? Appreciate my hard work, time, and effort?


<h1>How about buying me a <img src="https://cdn.rawgit.com/bcurran3/ChocolateyPackages/master/mylogos/beer.png" alt="" width="40" height="40"> via PayPal?</h1>

[![PayPal Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

<h1>Better yet... Keep me incentivized by Patreonizing me!</h1>

[![Patreonize me!](https://c5.patreon.com/external/logo/downloads_wordmark_white_on_coral.png)](https://www.patreon.com/bcurran3)


If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Bill</h3>
