<img src="https://cdn.staticaly.com/gh/bcurran3/ChocolateyPackages/master/mylogos/myunofficialChocolateylogo_icon.png" width="139" height="88">

**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original! So of course I endorse and use it. :)

![Screenshot of (unofficial) Choco Package List Backup to Local and Cloud (Script)](https://cdn.staticaly.com/gh/bcurran3/ChocolateyPackages/master/choco-package-list-backup/choco-package-list-backup.ps1_screenshot.png)
	
#choco-package-list-backup solves your Chocolatey migration and package re-installation problems!

**choco-package-list-backup** is a script I wrote that will backup the list of your currently installed Chocolatey packages and save them to a PACKAGES.CONFIG file. You can then use that PACKAGES.CONFIG file to re-install all your packages on another computer or even the same computer later if it crashes. "How can I re-install on the same computer if it crashed and I lost the PACKAGES.CONFIG file?" Thanks for asking! **choco-package-list-backup** backs up your package list locally and to multiple cloud services!

###FEATURES:

**choco-package-list-backup** supports saving PACKAGES.CONFIG to all of the following:

* your local Documents folder
* your Active Directory assigned HOMESHARE
* Box
* Dropbox Personal and Business
* Google Drive and Drive File Stream
* iCloudDrive
* Microsoft OneDrive
* NETGEAR ReadyCLOUD
* Nextcloud
* ownCloud
* Resilio Sync
* Seafile
* TonidoSync
* A custom location of your choice
* more coming - Let me know what you want/need!

**choco-package-list-backup** runs on install to make sure you have backup(s) right now!

**choco-package-list-backup** supports copying [InstChoco](https://chocolatey.org/packages/instchoco) with the PACKAGES.CONFIG path for the fastest way ever to reinstall Chocolatey and your Chocolatey packages! (Or migrate!)

**choco-package-list-backup** supports backing up PERSISTENTPACKAGES.CONFIG if you are using [choco-persistent-packages](https://chocolatey.org/packages/choco-persistent-packages)

**choco-package-list-backup** integrates with [Chocolatey Shortcuts](https://chocolatey.org/packages/choco-shortcuts-winconfig) if installed.

**choco-package-list-backup** saves in computer (name) specific folders so you can backup your Chocolatey package list from multiple computers to the same cloud destination(s). No confusion over what computer gets what packages!

**choco-package-list-backup** saves a list of all your installed programs (AllProgramsList.txt) whether they were installed by Chocolatey or not.

**choco-package-list-backup** is configurable. You can:

* configure which locations you want or don't want to save to (default=all the locations found except the custom location)
* configure to save package version information or not (default=false)
* configure to append a date to the saved packages.config (default=false)
* configure what folder to save to (default=ChocolateyPackageListBackup)
* easily add a custom location by editing CustomPath and UseCustomPath in the .xml configuration file
* configure to save a list of all your installed Windows programs whether installed by Chocolatey or not to AllProgramsList.txt (default=true)

**choco-package-list-backup** and choco-package-list-backup.xml are saved to Chocolatey's bin folder (\ProgramData\chocolatey\bin), so **choco-package-list-backup** is in your path.

**If you find choco-package-list-backup useful, and I suspect you will, please consider donating: https://www.paypal.me/bcurran3donations** or become a patron at https://www.patreon.com/bcurran3

###INSTRUCTIONS:

* Edit \ProgramData\chocolatey\bin\choco-package-list-backup.xml to customize your backup(s). It's easy, there are comments.
* From PowerShell, type CHOCO-PACKAGE-LIST-BACKUP.PS1 to backup your Chocolatey packages list. 
* From Command Prompt, type POWERSHELL CHOCO-PACKAGE-LIST-BACKUP.PS1 to backup your Chocolatey packages list. 
* From Windows, click Chocolatey Package List Backup in the Windows Start Menu or Package List Backup inside the Chocolatey folder if [Chocolatey Shortcuts](https://chocolatey.org/packages/choco-shortcuts-winconfig) is installed.

###CHANGELOG:
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

###ROADMAP:
* Investigate running the schedule task from the installing user account.
* Add other cloud services support by request.
* I'm open to suggestions - open a GitHub issue please.

***

Like my [original Chocolatey add-ons and packages](https://chocolatey.org/search?q=tag%3Abcurran3)? or my [400+ other program packages](https://chocolatey.org/profiles/bcurran3)? Find them useful? Appreciate my hard work, time, and effort?


<h1>How about buying me a <img src="https://cdn.rawgit.com/bcurran3/ChocolateyPackages/master/mylogos/beer.png" alt="" width="40" height="40"> via PayPal?</h1>

[![PayPal Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

<h1>Better yet... Keep me incentivized by Patreonizing me!</h1>

[![Patreonize me!](https://c5.patreon.com/external/logo/downloads_wordmark_white_on_coral.png)](https://www.patreon.com/bcurran3)


If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Bill</h3>
