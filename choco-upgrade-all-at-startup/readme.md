<img src="https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/InstChoco/InstChoco_icon.png" width="139" height="88">

**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original! (Inspired by https://daniel.streefkerkonline.com/2016/02/23/create-a-scheduled-task-to-keep-all-chocolatey-packages-up-to-date/)
* This may NOT work on Windows 7 / Windows Server 2012. I've added PowerShell v4 as a dependency in hopes it will work.
* I previously used this package but now use [choco-upgrade-all-at](https://chocolatey.org/packages/choco-upgrade-all-at).
* This is most likely the last release of choco-upgrade-all-at-startup.

#DO YOU WANT TO UPGRADE YOUR CHOCOLATEY PACKAGES EVERY TIME YOUR COMPUTER BOOTS? 

#YOU JUST FOUND THE EASY WAY!
	
###This package creates a Windows Scheduled Task to run "choco upgrade all -y" every time your computer boots.

###NOTE:
Your computer boot time will increase! If you reboot daily, you'll never notice. If you reboot infrequently, you'll notice a slow down as packages are downloaded and updated/installed, especially if you have a slow Internet connection. Because of this **choco-upgrade-all-at-startup** is pseudo-deprecated and pseudo-superseded by **[choco upgrade all at](https://chocolatey.org/packages/choco-upgrade-all-at)** which allows you to set a time to run "choco upgrade all -y" every day in the wee hours of morning while you're happily dreaming about supercomputers and not waiting for your computer to boot up.

##CHANGELOG:
* 2018.08.22 - Fixed compatibility with Windows 7 &amp; 8 machines by using SchTasks.exe for everything and not using the Windows 10/Server 2016 only get-scheduledtask cmdlet. Removed PowerShell v4/v5 dependency.
* 2018.01.30 - simplified, standardized, description updated, uninstall added
* 2017.01.10 - original release

##ROADMAP:
* Nothing planned

***

Like my [original Chocolatey add-ons and packages](https://chocolatey.org/search?q=tag%3Abcurran3)? or my [400+ other program packages](https://chocolatey.org/profiles/bcurran3)? Find them useful? Appreciate my hard work, time, and effort?


<h1>How about buying me a <img src="https://cdn.rawgit.com/bcurran3/ChocolateyPackages/master/mylogos/beer.png" alt="" width="40" height="40"> via PayPal?</h1>

[![PayPal Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

<h1>Better yet... Keep me incentivized by Patreonizing me!</h1>

[![Patreonize me!](https://c5.patreon.com/external/logo/downloads_wordmark_white_on_coral.png)](https://www.patreon.com/bcurran3)


If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Bill</h3>



