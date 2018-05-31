<img src="https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/forceps/ForcePS_icon.png" width="100" height="100">

**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original! So of course I endorse and use it. :)

![Screenshot of ForcePS](https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/forceps/ForcePS_screenshot.png)
	
##ForcePS - Allows you to run a PowerShell script from the Command Prompt bypassing Windows PowerShell Script Execution Policy.

###No more "File PSscript.ps1 cannot be loaded because running scripts is disabled on this system." messages!

####"Laziness is the mother of invention."

I wrote **ForcePS** because I was lazy and didn't want to keep changing my Windows PowerShell Script Execution Policy back and forth to run scripts. So I made a little one line batch file that would call PowerShell with the appropriate parameters to bypass the execution policy. Now I've added some error checking, compiled it, and have released it to the world for others who can't remember or don't want to have to type "Set-ExecutionPolicy Unrestricted" and "Set-ExecutionPolicy Restricted" repeatedly. Now you can just run **ForcePS** from the Command Prompt followed by the name of a PowerShell script and... Walah! The PS script will run without hassle, all without you having to change any settings. Elevated Command Prompt required for some small sense of security.

Chocolatey will download **ForcePS** to the package's tools directory and shim it so that its available for global use.

USAGE: ForcePS PSscript.ps1 parameter1 parameter2

CHANGELOG:
v1.0.0.1 - updated donation link :)
v1.0 - initial release

Like my [packages](https://chocolatey.org/profiles/bcurran3)? 

Find them useful?

**Want to buy me a beer?**

[![Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

If applicable, please always consider donating to the developer or purchasing the software first - this includes [Chocolatey licensed editions](https://chocolatey.org/pricing).

