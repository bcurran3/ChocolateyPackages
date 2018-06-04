**BCURRAN3'S PACKAGE NOTES:**

* This package downloads the installer via a version specific URL. It should never fail unless the version is completely removed from the vendor website.
* v1.6.16 checksum changed, it's ASSUMED the installer changed but the program didn't.
* DISCLAIMER: This package uses an AutoHotKey script to attempt automatic installation of the program. I have done my best to make this work for the majority, there are always a number of x-factors that can cause a 'hiccup.' Some events are timed and may timeout and thus fail on slower than expected systems. It is HIGHLY RECOMMENDED that you monitor the installation of this package to make sure it worked/installed correctly in your environment. There are situations such as upgrades and forced reinstalls that may not work and you will have to manually enter input to get the desired result. If you report an issue in GitHub and the program is in active development, I will try to enhance the AHK script and this package in the future.
* I had to take some liberties with this install. The MAK address for your TiVos has been entered as 1234567890, you will need to change it. The default to save/send video files is set to C:\TEMP, change it to what you want.
* This will NOT upgrade correctly - you will HAVE TO manually interact with the upgrade. Steps to update the AutoHotKey script to handle this are in progress.
* I personally use and endorse this program.

Like my [packages](https://chocolatey.org/profiles/bcurran3)? 

Find them useful?

**Want to buy me a beer?**

[![Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

If applicable, please always consider donating to the developer or purchasing the software first - this includes [Chocolatey licensed editions](https://chocolatey.org/pricing).