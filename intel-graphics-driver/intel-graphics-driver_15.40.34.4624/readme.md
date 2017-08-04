**BCURRAN3'S PACKAGE NOTES:**

* This package downloads the installer via a version specific URL. It should never fail unless the version is completely removed from the vendor website.
* This version of Intel Graphics Driver supports 32 bit and 64 bit OSes, newer versions only support 64 bit OSes. You may want to [pin](https://github.com/chocolatey/choco/wiki/CommandsPin) this version if you are using a 32 bit version of Windows.
* If you are using computer manufacturer "customized" drivers (Dell/HP/others) and getting a "These drivers are Intel generic drivers. They do not include customizations that your manufacturer might have added to optimize your computing experience." and you wish to use these "generic" drivers, here's the way to do it - ONCE you have to:

1. Download the driver install program from Intel (look at chocolateyInstall.ps1 for link)
2. Unzip the install program to a directory (it's a self-extracting/executing ZIP)
3. Locate the .INF file for the driver (Graphics\igdlh64.inf), right click and choose to install it
4. You might have to wait a bit for it to complete - it will notify you
5. Uninstall your current Intel display driver from Device Manager and DO NOT reboot.
6. In Device Manager tell it to search for updated hardware, it should find and use the new one.
7. After finding the Intel graphics driver, check to make sure it's the new version. (Worked for me on first go.) Change it if not.

After you've done this, the drivers can be updated regularly via the Intel® Graphics Driver for Windows installation program, and Chocolatey of course! CYA Statement: I did step #5 first when I did this on multiple computers.

Like my [packages](https://chocolatey.org/profiles/bcurran3)? 

Find them useful?

**Want to buy me a beer?**

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=4ECL3UCG5CGB6)

If applicable, please always consider donating to the developer or purchasing the software first - this includes Chocolatey licensed editions. 
