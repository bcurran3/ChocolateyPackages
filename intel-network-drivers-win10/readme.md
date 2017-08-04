**BCURRAN3'S PACKAGE NOTES:**

* This program is updated semi-frequently. The download URL in this package will always download the latest version. Versions of the program released after this package will fail checksums. If you get an error installing this package please try --ignore-checksums and open a GitHub Issue requesting the package to be updated.
* At some point in the future this package will be setup for creation by Auto Update (when I figure it out) which will solve the above problem.
* This package checks for already installed Intel adapter drivers before installing and will throw an exception if none are found. Howerver it does not verify you have supported Intel drivers, just an already installed Intel network adapter. Thus it also fails Chocolatey's automated testing.
* Intel® Network Adapter Driver for Windows® 10 (Install) 22.3 never worked. Apologies to the 68 people who downloaded it and THOUGHT it installed, it didn't.

Like my [packages](https://chocolatey.org/profiles/bcurran3)? 

Find them useful?

**Want to buy me a beer?**

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=4ECL3UCG5CGB6)

If applicable, please always consider donating to the developer or purchasing the software first - this includes Chocolatey licensed editions. 
