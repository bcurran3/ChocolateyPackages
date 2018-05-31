<img src="https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/InstChoco/InstChoco_icon.png" width="139" height="88">

**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original! (Inspired by https://daniel.streefkerkonline.com/2016/02/23/create-a-scheduled-task-to-keep-all-chocolatey-packages-up-to-date/)
* This may NOT work on Windows 7 / Windows Server 2012. I've added PowerShell v4 as a dependency in hopes it will work.
* I previously used this package but now use [choco-upgrade-all-at](https://chocolatey.org/packages/choco-upgrade-all-at).
* This is most likely the last release of choco-upgrade-all-at-startup.

#DO YOU WANT TO UPGRADE YOUR CHOCOLATEY PACKAGES EVERY TIME YOUR COMPUTER BOOTS? 

#YOU JUST FOUND THE EASY WAY!
	
###This package creates a Windows Scheduled Task to run "choco upgrade all -y" every time your computer boots.

**WARNING:** Your computer boot time will increase! If you reboot daily, you'll never notice. If you reboot infrequently, you'll notice a slow down as packages are updated, especially if you have a slow Internet connection. Because of this **choco-upgrade-all-at-startup** is pseudo-deprecated and pseudo-superseded by [choco upgrade all at](https://chocolatey.org/packages/choco-upgrade-all-at) which allows you to set a time to run "choco upgrade all -y" every day in the wee hours of morning while you're happily dreaming about supercomputers and not waiting for your computer to boot up.

CHANGELOG:
* 2018.01.30 - simplified, standardized, description updated, uninstall added
* 2017.01.10 - original release

Like my [packages](https://chocolatey.org/profiles/bcurran3)? 

Find them useful?

**Want to buy me a beer?**

[![Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

If applicable, please always consider donating to the developer or purchasing the software first - this includes [Chocolatey licensed editions](https://chocolatey.org/pricing).



