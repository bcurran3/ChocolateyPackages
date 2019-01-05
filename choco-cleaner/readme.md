<img src="https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/InstChoco/InstChoco_icon.png" width="139" height="88">

![Screenshot of Choco-Cleaner](https://cdn.rawgit.com/bcurran3/ChocolateyPackages/bd713cc4/choco-cleaner/choco-cleaner_screenshot.png)	

**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original! So of course I endorse and use it. :)
* If you don't like the default scheduled time to run, you can easily change it using Window's TaskScheduler.
* I'm open to suggestions - open a GitHub issue please.

##DO YOU WANT TO RECOVER SOME DISK SPACE USED BY UNNECESSARY RESIDUAL CHOCOLATEY FILES? 

##YOU JUST FOUND THE EASY WAY!

####This package creates a Windows Scheduled Task to run Choco-Cleaner.ps1 every Sunday at 11:00 PM.

##**BEFORE and AFTER Choco-Cleaner: (198 packages installed and does not include temp folder deletions.)**
![schreenshot of files and diskspace  before Choco-Cleaner](https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/choco-cleaner/choco-cleaner_before.png) ![schreenshot of files and diskspace after choco-cleaner](https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/choco-cleaner/choco-cleaner_after.png)

**Sure, you're probably not going to get gigabytes of space back, but every few KB matters on some computers and to some people! Due to [slack space](https://www.computerhope.com/jargon/s/slack-space.htm) small files such as 6 byte .ignore files actually take up 4 KB of HDD space each.**

##FEATURES:

Set it and forget it! **Choco-Cleaner** cleans up your Chocolatey installation every Sunday at 11 PM in the background so you don't have to be bothered with it.

**Choco-Cleaner** is completely configurable, just edit \ProgramData\chocolatey\bin\Choco-Cleaner.xml and set true/false for any grouping of file types you want to delete or not. License and log files default to false. This has been mandated to me for passing moderation. Everything else listed below is deleted by default.
	
**Choco-Cleaner deletes:**

* .log files that are not the most current one (NOT default)
* .zip, .rar, .iso, and various archive files left over from packages that forgot to delete them post install
* .zip.txt and other archive-extensions.txt are lists of files that were extracted from an archive file for installation
* .msi, .msu, and .msp are Microsoft intall packages left over from packages that forgot to delete them post install
* .ignore files that are created to not shim executables during package install but not needed after shim operations are finished (This may change in a future version of Chocolatey.)
* credits.txt are program credits (of contributors) files you can read on the web
* readme.txt files you can read on the web
* .md files are usually markdown readme files that you can read on the web
* .old files are Chocolatey files that have been replaced by newer versions (exe's and dll's mostly)
* chocolatey.config.backup is a backup of your chocolatey.config file
* _processed.txt - I have no idea what made this file or why it exists
* lib-bad holds packages that failed to install and lib-bkp contains aborted packages (during updates?) 
* archives and executables out of .nuspkg files which are ZIP archives with NuGet package information - this is similar to what [Package Reducer](https://chocolatey.org/docs/features-package-reducer) does
* \users\username\AppData\Local\Temp\chocolatey is where new package files are downloaded to during pre-installation (if you haven't changed your cacheLocation in chocolatey.config)
* files in cacheLocation if set in chocolatey.config
* \users\username\AppData\Local\Nuget\Cache if Nuget client is installed and caching files there
* \Windows\Temp\chocolatey 
* license.txt and verification.txt files are included when packages include binaries, you can read them on the package web page, programname.license.txt files are license files for Chocolatey default tools (NOT default)

##INSTRUCTIONS:

To manually run **Choco-Cleaner**:

* Command Prompt: \ProgramData\chocolatey\lib\choco-cleaner\tools\Choco-Cleaner-manual.bat
* PowerShell: \ProgramData\chocolatey\bin\Choco-Cleaner.ps1
* Windows Start Menu: click the icon. If you have **[choco-shortcuts-winconfig](https://chocolatey.org/packages/choco-shortcuts-winconfig)** installed you'll find it with the rest of the Chocolatey Shortcuts.

If you have a previous release of **Choco-Cleaner** installed, upgrading to a new version will NOT modify your current scheduled task or preferences.

11:00 PM was chosen as not to conflict with default installs of **[choco-upgrade-all-at](https://chocolatey.org/packages/choco-upgrade-all-at)**,  **[choco-persistent-packages](https://chocolatey.org/packages/choco-persistent-packages)**, and **[choco-optimize-at](https://chocolatey.org/packages/choco-optimize-at)**.

**Organizations with software license compliance auditing should probably NOT delete the license and verification files for legal protection. The supplied configuration file defaults to false for these types of files. As ferventcoder/Rob has said many times, corporations are not advised to use the community repository and should be using [Chocolatey for Business](https://chocolatey.org/pricing) with their own internalized local packages.**

CHANGELOG:
* 0.0.5.2 - minor update to delete .img (alternate .iso name), and .msi,.msu, and .msp files in toolsDir, as well as minor cosmetic changes
* 0.0.5.1 - made PowerShell Core compatible
* 0.0.5 - added deletion of cacheLocation if defined in chocolatey.config, cosmetic changes, removed 7Zip dependency and now using the version of 7Zip packaged with Chocolatey.
* 0.0.4 - added deletion of Nuget Cache folder files
* 0.0.3.1 - fixed typo causing nupkg files to NOT be optimized - thanks E.R.! 
* 0.0.3 - Rewritten version of 0.0.1 with XML configuration file and ferventcoder/Rob's approved default settings. Minor improvements.
* 0.0.2 - Unreleased version with two scripts with different default settings; "Bill's way" and "Rob's way" and a package parameter to choose which one to use/install. Shelved.
* 0.0.1 - Initial release. Did not pass Chocolatey moderation due to mandated changes of default parameters. Only "secretly" available.

###ROADMAP:
* Clean up C:\ProgramData\chocolatey\.chocolatey
* Clean up C:\ProgramData\chocolatey\lib-synced (licensed versions)

***

Like my [original Chocolatey add-ons and packages](https://chocolatey.org/search?q=tag%3Abcurran3)? or my [400+ other program packages](https://chocolatey.org/profiles/bcurran3)? Find them useful? Appreciate my hard work, time, and effort?


<h1>How about buying me a <img src="https://cdn.rawgit.com/bcurran3/ChocolateyPackages/master/mylogos/beer.png" alt="" width="40" height="40"> via PayPal?</h1>

[![PayPal Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

<h1>Better yet... Keep me incentivized by Patreonizing me!</h1>

[![Patreonize me!](https://c5.patreon.com/external/logo/downloads_wordmark_white_on_coral.png)](https://www.patreon.com/bcurran3)


If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Bill</h3>
