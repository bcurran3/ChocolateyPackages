<img src="https://cdn.staticaly.com/gh/bcurran3/ChocolateyPackages/master/forceps/ForcePS_icon.png" width="100" height="100">

**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original! So of course I endorse and use it. :)

![Screenshot of ForcePS](https://cdn.staticaly.com/gh/bcurran3/ChocolateyPackages/master/forceps/ForcePS_screenshot.png)
	
##ForcePS - Allows you to run a PowerShell script from the Command Prompt bypassing Windows PowerShell Script Execution Policy.

###No more "File PSscript.ps1 cannot be loaded because running scripts is disabled on this system." messages!

####"Laziness is the mother of invention."

I wrote **ForcePS** because I was lazy and didn't want to keep changing my Windows PowerShell Script Execution Policy back and forth to run scripts. So I made a little one line batch file that would call PowerShell with the appropriate parameters to bypass the execution policy. Now I've added some error checking, compiled it, and have released it to the world for others who can't remember or don't want to have to type "Set-ExecutionPolicy Unrestricted" and "Set-ExecutionPolicy Restricted" repeatedly. Now you can just run **ForcePS** from the Command Prompt followed by the name of a PowerShell script and... Walah! The PS script will run without hassle, all without you having to change any settings. Elevated Command Prompt required for some small sense of security.

Chocolatey will download **ForcePS** to the package's tools directory and shim it so that its available for global use.

USAGE: ForcePS PSscript.ps1 parameter1 parameter2

CHANGELOG:
* v1.0.0.1 - updated donation link :)
* v1.0 - initial release

***

Like my [original Chocolatey add-ons and packages](https://chocolatey.org/search?q=tag%3Abcurran3)? or my [400+ other program packages](https://chocolatey.org/profiles/bcurran3)? Find them useful? Appreciate my hard work, time, and effort?


<h1>How about buying me a <img src="https://cdn.rawgit.com/bcurran3/ChocolateyPackages/master/mylogos/beer.png" alt="" width="40" height="40"> via PayPal?</h1>

[![PayPal Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

<h1>Better yet... Keep me incentivized by Patreonizing me!</h1>

[![Patreonize me!](https://c5.patreon.com/external/logo/downloads_wordmark_white_on_coral.png)](https://www.patreon.com/bcurran3)


If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Bill</h3>