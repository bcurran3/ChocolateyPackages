<img src="https://cdn.staticaly.com/gh/bcurran3/ChocolateyPackages/master/mylogos/myunofficialChocolateylogo_icon.png" width="139" height="88">

**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original!
* Read the INSTALL EXAMPLES again before use!
* You MUST be a Chocolatey licensed customer or this package will abort install.
* I personally use and endorse this script/package/task/.

##**choco-optimize-at** periodically reduces the size of downloaded Chocolatey .nupkg package files thus saving HDD space. This package creates a Windows Scheduled Task to run "[choco optimize](https://chocolatey.org/docs/commands-optimize)" at a time you specify. 

###WHO IS THIS FOR?
 **choco-optimize-at** is designed for [Chocolatey Pro](https://chocolatey.org/pricing) and [Chocolatey Business](https://chocolatey.org/pricing) licensed users who want to automate optimization of storage space used by their Chocolatey .nupkg files.


###INSTRUCTIONS:
You can install **choco-optimize-at** with multiple parameters to make it run "[choco optimize](https://chocolatey.org/docs/commands-optimize)" daily or weekly at your preferred time. If you enter no parameters at all, **choco-optimize-at** will default to run "[choco optimize](https://chocolatey.org/docs/commands-optimize)" at 5 AM every SUNDAY. When entering the TIME parameter, use "[Military Time](http://militarytimechart.com/)." When entering the DAILY or WEEKLY parameter you can actually use anything, "yes" just makes sense though. When using the WEEKLY parameter, DAYS are entered as MON, TUE, WED, THU, FRI, SAT, or SUN. Not entering the correct format will fail the install. Please see the examples below.

###INSTALL EXAMPLES:
* **choco install choco-optimize-at** - optimizes packages on SUNDAYS at 5 AM. (My preference!) 
* **choco install choco-optimize-at --params "'/TIME:23:00'"** - optimizes packages on SUNDAYS at 11 PM
* **choco install choco-optimize-at --params "'/DAILY:yes /TIME:06:00'"** - optimizes packages daily at 6 AM
* **choco install choco-optimize-at --params "'/WEEKLY:yes /DAY:SAT /TIME:01:00'"** - optimizes packages on SATURDAYS at 1 AM

####A NOTE ON DEFAULTS:
* If you don't specify any parameters, **choco-optimize-at** defaults to running every Sunday at 5 AM. (My preference!) This default time was chosen to be compatible with with default run times used by **[choco-upgrade-all-at](https://chocolatey.org/packages/choco-upgrade-all-at)** and **[choco-persistent-packages](https://chocolatey.org/packages/choco-persistent-packages)**.
* Not specifying a time will always default to 5 AM.
* When WEEKLY is specified but a DAY isn't, default first run will be a week from installation date; i.e. next week on whatever day of the week you installed the package.

CHANGE LOG:
0.0.1.1 - removed unintentional forgotten code that caused WEEKLY with no other parameters to abort.
0.0.1   - initial release

***

Like my [original Chocolatey add-ons and packages](https://chocolatey.org/search?q=tag%3Abcurran3)? or my [400+ other program packages](https://chocolatey.org/profiles/bcurran3)? Find them useful? Appreciate my hard work, time, and effort?


<h1>How about buying me a <img src="https://cdn.rawgit.com/bcurran3/ChocolateyPackages/master/mylogos/beer.png" alt="" width="40" height="40"> via PayPal?</h1>

[![PayPal Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

<h1>Better yet... Keep me incentivized by Patreonizing me!</h1>

[![Patreonize me!](https://c5.patreon.com/external/logo/downloads_wordmark_white_on_coral.png)](https://www.patreon.com/bcurran3)


If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Bill</h3>