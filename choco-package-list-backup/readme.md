<img src="https://cdn.staticaly.com/gh/bcurran3/ChocolateyPackages/master/mylogos/myunofficialChocolateylogo_icon.png" width="139" height="88">

**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original! So of course I endorse and use it. :)

***	
[choco://choco-package-list-backup](choco://choco-package-list-backup)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://chocolatey.org/packages/choco-protocol-support)
***

![Screenshot of (unofficial) Choco Package List Backup to Local and Cloud (Script)](https://cdn.staticaly.com/gh/bcurran3/ChocolateyPackages/master/choco-package-list-backup/choco-package-list-backup_screenshot.png)
	
# **choco-package-list-backup** solves your Chocolatey migration and package re-installation problems!

## **choco-package-list-backup (CPLB)** is a script I wrote that will backup the list of your currently installed Chocolatey packages and save them to a PACKAGES.CONFIG file. You can then use that PACKAGES.CONFIG file to re-install all your packages on another computer or even the same computer later if it crashes. "How can I re-install on the same computer if it crashed and I lost the PACKAGES.CONFIG file?" Thanks for asking! **CPLB** backs up your package list locally AND to multiple cloud services! But wait, there's more! **CPBL** also saves your pinned package info. But wait, there's even more! **CPBL** also saves a list of ALL your programs even if they weren't installed by Chocolatey. Pretty darn cool huh?

### FEATURES:
* **CPLB** supports saving PACKAGES.CONFIG to all of the following:
     01. your local Documents folder
     02. your Active Directory assigned HOMESHARE
     03. Box
     04. Dropbox Personal and Business
     05. Google Drive and Drive File Stream
     06. iCloudDrive
     07. Microsoft OneDrive (free, paid consumer, and corporate)
     08. NETGEAR ReadyCLOUD
     09. Nextcloud
     10. ownCloud
     11. Resilio Sync
     12. Seafile
     13. TonidoSync
     14. A custom location of your choice
     15. C:\Users\Public when run from system account
* **CPLB** runs on install to make sure you have backup(s) right now!
* **CPLB** backups every Monday at 6 AM in the background to C:\Users\Public. Set it and forget it! 
* **CPLB** supports copying [InstChoco - The ULTIMATE Chocolatey and Chocolatey packages (re)installer!](https://chocolatey.org/packages/instchoco) to your PACKAGES.CONFIG backup location(s) for the fastest way ever to reinstall Chocolatey and your Chocolatey packages! (Or migrate!)
* **CPLB** supports backing up PERSISTENTPACKAGES.CONFIG if you are using [Choco Persistent Packages](https://chocolatey.org/packages/choco-persistent-packages).
* **CPLB** integrates with [Chocolatey Shortcuts](https://chocolatey.org/packages/choco-shortcuts-winconfig).
* **CPLB** saves in computer (name) specific folders so you can backup your Chocolatey package list from multiple computers to the same cloud destination(s). No confusion over what computer gets what packages!
* **CPLB** saves a list of all your installed programs (AllProgramsList.txt) whether they were installed by Chocolatey or not.
* **CPLB** saves your pinned information to pins.bat for easy re-pinning packages.
* **CPLB** is in your path and ready to run.
* **CPLB** is configurable. You can:
     1. configure which locations you want or don't want to save to (default=all the locations found except the custom location)
     2. configure to save package version information or not (default=false)
     3. configure to save package title and summary information or not (default=false)
     4. configure to append a date to the saved packages.config, AllProgramsList.txt, and pins.bat files(default=false)
     5. configure what folder to save to (default=ChocolateyPackageListBackup)
     6. easily add a custom location by editing CustomPath and UseCustomPath in the .config file
     7. configure to save a list of all your installed Windows programs whether installed by Chocolatey or not to AllProgramsList.txt (default=true)

**If you find choco-package-list-backup useful, and I suspect you will, please consider donating: https://www.paypal.me/bcurran3donations or become a patron at https://www.patreon.com/bcurran3**

### OPTIONAL INSTALLATION INSTRUCTIONS:
* **choco install choco-package-list-backup --params "'/ONSTART:TRUE'"** - scheduled task to run at boot instead of at a scheduled time
* **choco install choco-package-list-backup --params "'/NOTASK:TRUE'"** - won't configure a scheduled task
* **choco install choco-package-list-backup --params "'/NORUN:TRUE'"** - won't run the script upon install (let's you configure before first run)

### INSTRUCTIONS:
* Edit C:\tools\BCURRAN3\choco-package-list-backup.config to customize your backup(s). It's easy, there are comments. Run CPLB or CHOCO-PACKAGE-LIST-BACKUP -EditConfig
* From PowerShell or the Command Prompt, type CPLB or CHOCO-PACKAGE-LIST-BACKUP to backup your Chocolatey packages list.
* From Windows, click Chocolatey Package List Backup in the Windows Start Menu or Package List Backup inside the Chocolatey folder if [Chocolatey Shortcuts](https://chocolatey.org/packages/choco-shortcuts-winconfig) is installed.	

### CHANGELOG:
* 2022.02.06 - All existing files now renamed with .bak before creating new versions. This backup is useful during migrations where the files could get overwritten during install of CPLB on a new computer. (https://github.com/bcurran3/ChocolateyPackages/issues/285)
* 2021.09.25 - Improved OneDrive support while running under SYSTEM and handling of a missing config file.
* 2021.09.22 - Add Box Drive support. Add defaults incase of corrupt or missing choco-package-list-backup.config. Add new ONSTART and ATSTARTUP paremeters to run at boot instead of a scheduled time.
* 2021.05.10 - Speed optimations by TheCakeIsNaOH - Thanks!
* 2021.04.08 - Fixed missing UseCustomPath2 variable import. Thanks matteotrubini! Removed duplication of "shim" creation.
* 2021.03.22 - Added 2nd custom path option, added saved arguments option thanks to TheCakeIsNaOH, added pre and post processing option
* 2021.03.15 - Added NORUN/DONTRUN install option (choco install choco-package-list-backup --params "'/NORUN:TRUE'".)
* 2021.03.14 - Fixed wrong command in scheduled task. Fixed saving to C:\Users\Public\Documents. Fixed problem when SaveTitleSummary is set to true and there is no chocolatey.nuspec file to get values from. Added ability to set default user profile. Added start/finished logging. Added NOTASK/NOSCHEDULE install option (choco install choco-package-list-backup --params "'/NOTASK:TRUE'".) Minor other changes.
* 2020.04.06 - Better error handling when $env:ChocolateyToolsLocation is not defined. (Usually due to running under a different account than installed from.)Acronymized CPLB.cmd added for command line running.
* 2019.08.27 - can now put title and summary info into the packages.config file, new -EditConfig parameter to edit the config file, **Now works from Command Prompt as well as PowerShell**, script installation endpoint changed, config file renamed from .xml to .config
* 2019.07.02 - now saves OneDrive backups to free, paid, and corporate folders
* 2019.06.27 - now backups the config file, can now also make archival versions of pins.bat, edited config comments to not add quotes to custom path.
* 2019.01.31 - file saving functions re-written and optimized, check for errors caused by other Chocolatey instances
* 2019.01.29 - fixed bug where iCloudDrive preference wasn't checked correctly, thanks sandscap-sc!
* 2019.01.24 - now saves your pinned package information to pins.bat, added saving to c:\users\Public when run from system account (e.g. scheduled task), fixed error attempting to create files under system account Documents folder which doesn't exist, packages.config now properly UTF-8 encoded, speed optimizations, minor cosmetic changes
* 2019.01.04 - 2019.01.02 didn't get packaged with the install and uninstall scripts! - fixed (GitHub bit me)
* 2019.01.02 - Will now write to Documents/MyDocuments if the folder has been moved, thanks Aaron Throckmorton for the enhancement!
* 2018.08.23 - Added ownCloud support and save all programs list feature
* 2018.06.21 - Added scheduled task to run every Monday at 6 AM. AppendDate option now saves packages.config AND a packages_date.config. This makes the AppendDate option more useful for a nearline packages.config and archival snapshots as well as fixing compatibility with InstChoco.
* 2018.05.19 - OneDrive and shortcut creation bugs fixed, minor cosmetic changes
* 2018.05.17 - added iCloudDrive support
* 2018.05.09 - added reading preferences from choco-package-list-backup.xml - no more editing the script after upgrades! Backups not created any more.
* 2018.05.06 - added Dropbox Business and Google Drive File Stream support (Thanks ebbek!)
* 2018.04.25 - removed run as admin requirement
* 2018.04.25 - now makes a backup of previous choco-packages-list-backup.ps1 (Since removed.)
* 2018.04.25 - fixed minor text output error
* 2018.04.25 - added compatibility with [choco-shortcuts-winconfig](https://chocolatey.org/packages/choco-shortcuts-winconfig)
* 2018.04.24.01 - added ability to append the date to PACKAGES.CONFIG 
* 2018.04.24 - added [choco-persistent-packages](https://chocolatey.org/packages/choco-persistent-packages) support.
* 2018.04.23 - now backups up packages automatically on install
* 2018.02.24 - added Box and Seafile support as well as an icon to run from the Windows Start menu
* 2018.02.12 - added Nextcloud support (thanks thomasaiman) and fixed TonidoSync (Thanks thomasaiman!)
* 2018.01.29 - edited re-installation message, updated donation info :)
* 2017.12.17 - added editable custom save location (requested)

#### ROADMAP:
* Possibly convert to use regkey install path for each supported program
* Add other cloud services support by request
* I'm open to suggestions - open a GitHub issue please.

***

Like my [original Chocolatey add-ons and packages](https://community.chocolatey.org/packages?q=tag%3Abcurran3)? or my [400+ other program packages](https://chocolatey.org/profiles/bcurran3)? Find them useful? Appreciate my hard work, time, and effort?


<h1>How about buying me a <img src="https://cdn.rawgit.com/bcurran3/ChocolateyPackages/master/mylogos/beer.png" alt="" width="40" height="40"> via PayPal?</h1>

[![PayPal Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

<h1>Better yet... Keep me incentivized by Patreonizing me!</h1>

[![Patreonize me!](https://c5.patreon.com/external/logo/downloads_wordmark_white_on_coral.png)](https://www.patreon.com/bcurran3)


If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Bill</h3>
