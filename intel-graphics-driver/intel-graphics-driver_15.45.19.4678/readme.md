**BCURRAN3'S PACKAGE NOTES:**

* This package downloads the installer via a version specific URL. It should never fail unless the version is completely removed from the vendor website.
* This package is ONLY for 64 bit OSes. It will throw an exception and fail on 32 bit versions of Windows.
* This package checks for already installed Intel adapter drivers before installing and will throw an exception if none are found. Howerver it does not verify you have supported Intel drivers, just an already installed Intel network adapter. Thus it also fails Chocolatey's automated testing.
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
