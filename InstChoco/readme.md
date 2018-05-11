**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original! So of course I endorse and use it. :)
* It is not recommended to run InstChoco without the -ynp switch on servers if you are using the Windows Active Directory Domain features!

ROADMAP:
* Possibly add domain security group specific package support; i.e. MARKETING needs GIMP but DEVELOPMENT doesn't. DEVELOPMENT needs NOTEPAD++ but MARKETING doesn't.
* Possibly add server specific support; i.e. Servers don't need all the packages that your workstations get from the packages in your domain package list. So maybe a DOMAINNAMEserverspackage.config would override if run on a server. Thinking...
* Add ability to use a different source other than the Chocolatey public repository. CANCELLED - sources can be listed inside packages.config.
* I'm open to suggestions - open a GitHub issue please.

CHANGELOG:
* 1.30 - Added ability to download a packages.config file from the web and install packages from it!
* 1.21 - Added Box, Nextcloud, and Seafile support to catch up with choco-package-list-backup.
* 1.20 - Added domain support to install predefined packages for domain joined computers and user specific packages.
* 1.11 - (unreleased) Added -ynp switch to skip installation of packages. (Install Chocolatey only)
* 1.10 - Added [Choco Package List Backup to Local and Cloud](https://chocolatey.org/packages/choco-package-list-backup) and [choco persistent packages](https://chocolatey.org/packages/choco-persistent-packages) support for package (re)installation. Cosmetic changes. Checks for year 2018 or greater instead of 2017 or greater. Updated donation info. :)
* 1.00 - initial release


Like my [packages](https://chocolatey.org/profiles/bcurran3)? 

Find them useful?

**Want to buy me a beer?**

https://www.paypal.me/bcurran3donations

If applicable, please always consider donating to the developer or purchasing the software first - this includes Chocolatey licensed editions.
