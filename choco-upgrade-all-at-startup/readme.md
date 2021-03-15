<img src="https://cdn.staticaly.com/gh/bcurran3/ChocolateyPackages/master/mylogos/myunofficialChocolateylogo_icon.png" width="139" height="88">

**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original! (Inspired by https://daniel.streefkerkonline.com/2016/02/23/create-a-scheduled-task-to-keep-all-chocolatey-packages-up-to-date/)
* This may NOT work on Windows 7 / Windows Server 2012. I've added PowerShell v4 as a dependency in hopes it will work.
* I previously used this package but now use [choco-upgrade-all-at](https://chocolatey.org/packages/choco-upgrade-all-at).
* This package will be updated at least one more time - see ROADMAP.

# DO YOU WANT TO UPGRADE YOUR CHOCOLATEY PACKAGES EVERY TIME YOUR COMPUTER BOOTS? 

# YOU JUST FOUND THE EASY WAY!
	
### This package creates a Windows Scheduled Task to run "choco upgrade all -y" with enhanced options every time your computer boots.

Please understand your computer boot time will increase. If you reboot daily, you'll probably never notice. If you reboot infrequently, you'll notice a slow down as packages are downloaded and updated/installed, especially if you have a slow Internet connection. Because of this **choco-upgrade-all-at-startup** is pseudo-deprecated and pseudo-superseded by **[choco upgrade all at](https://chocolatey.org/packages/choco-upgrade-all-at)** which allows you to set a time to run "choco upgrade all -y" every day in the wee hours of morning while you're happily dreaming of owning a supercomputer instead of twiddling your thumbs waiting for your "slow" computer to boot up. Otherwise it works wonderfully at keeping your Chocolatey installed programs up to date.

### USAGE INSTRUCTIONS:
* You can do nothing and it will run at startup when on AC power.
* You can manually run **choco-upgrade-all** from Command Prompt or PowerShell.
* You can manually run **choco-install packagename** from Command Prompt or PowerShell to install packages with your **choco-upgrade-all-at-startup** settings.

### POST INSTALL CONFIGURATION:
* To enable enhanced options such as automatically deleting newly installed Desktop and Start Menu icons, running pre and/or post processing scripts, or setting a default user profile, edit c:\tools\BCURRAN3\choco-upgrade-all.config or run **choco-upgrade-all -EditConfig**

SYSADMINS: I recommend use of **choco-upgrade-all-at-startup** for notebook/laptop users who tend to shut down their computers at night and thus miss scheduled updates/maintenance such as **[choco upgrade all at](https://chocolatey.org/packages/choco-upgrade-all-at)** (in the wee hours of the morning).

#### IF UPGRADING FROM A VERSION EARLIER THAN 2021.03.15:
It is **HIGHLY** advised you read the Release Notes/ChangeLog and **run choco-upgrade-all -EditConfig** to enable the new enhanced features.

## CHANGELOG:
* 2021.03.13 - Added option to automatically delete newly created Desktop and Start Menu icons. Added option to run pre and post processing scripts. Added configurable arguments. Added ability to set default user profile. Edit C:\tools\BCURRAN3\choco-upgrade-all.config to enable the enhanced options. You can new run choco-upgrade-all from the command line to take advantage of the enhanced options. Added choco-install script to work with the same enhanced options. Added -EditConfig option to edit the config file.
* 2018.08.22 - Fixed compatibility with Windows 7 &amp; 8 machines by using SchTasks.exe for everything and not using the Windows 10/Server 2016 only get-scheduledtask cmdlet. Removed PowerShell v4/v5 dependency.
* 2018.01.30 - simplified, standardized, description updated, uninstall added
* 2017.01.10 - original release

## ROADMAP:
* Re-write task creation using PowerShell cmdlets (instead of using schtasks) for advanced options such as enabling run on battery, limited execution time, only when a network is available, etc..

***

Like my [original Chocolatey add-ons and packages](https://chocolatey.org/search?q=tag%3Abcurran3)? or my [400+ other program packages](https://chocolatey.org/profiles/bcurran3)? Find them useful? Appreciate my hard work, time, and effort?


<h1>How about buying me a <img src="https://cdn.rawgit.com/bcurran3/ChocolateyPackages/master/mylogos/beer.png" alt="" width="40" height="40"> via PayPal?</h1>

[![PayPal Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

<h1>Better yet... Keep me incentivized by Patreonizing me!</h1>

[![Patreonize me!](https://c5.patreon.com/external/logo/downloads_wordmark_white_on_coral.png)](https://www.patreon.com/bcurran3)


If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Bill</h3>


