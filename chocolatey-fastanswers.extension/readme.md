<img src="https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/InstChoco/InstChoco_icon.png" width="139" height="88">

**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original!
* I personally (will) use and endorse this extension.

#**Chocolatey Fast Answers Extension** is a Chocolatey extension for use as a dependency by package maintainers.

#Purpose
To provide (fairly) easy to remember micro functions for (new?) package creators/maintainers to get short fast answers to common decision tree questions that come up during package creation. The majority of functions return True/False. None of the functions are complex and most rely on WMI. By using this Chocolatey extension you can easily script situations such as aborting an install for a package/program that doesn't work on servers by checking first using Get-IsWinServer or conversely Get-IsWinWorkstation. Maybe you have a package that needs to make sure there is not a pending reboot and you can check using Get-PendingReboot and error out with a message explaining to reboot and try again. Maybe you have a package that only runs on Windows 10 and Windows Server 2016, you can easy check at the beginning of your script using Get-IsWin10 or Get-IsWinServer2016. 

...and yes, nobody will probably use Get-IsSSD except me for some non-Chocolatey scripts! :) 
(Though IMHO defrag packages should abort if a SSD is found and warn that it's not recommended to defrag a SSD.)

The use cases go on...

#Functions
![List of functions](https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/chocolatey-fastanswers.extension/List_of_functions.png)

Screenshot testing all functions with simple test-package install script that does: $test=function and Write-Out function result for each function. Results from the functions show that the test package was run on a computer with Microsoft Windows 10 Pro build 16299 64bit, joined to a domain, (onboard) Intel video, (discreet) Nvidia video, has a SSD, is a workstation not a server, and is pending a reboot.
![](https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/chocolatey-fastanswers.extension/chocolatey-fastanswers.extension.png)

ROADMAP:
* Add more functions in my head such as Get-IsGEWin8 (Or Get-IsMin8?) for quick checking minimums. 
* Am open to any useful suggestions/additions!
* Do timing tests on WMI versus other methods for optimization.

Like my [packages](https://chocolatey.org/profiles/bcurran3)? 

Find them useful?

**Want to buy me a beer?**

[![Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

If applicable, please always consider donating to the developer or purchasing the software first - this includes [Chocolatey licensed editions](https://chocolatey.org/pricing).


