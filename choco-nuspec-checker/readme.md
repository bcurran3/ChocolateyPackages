<img src="https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/choco-nuspec-checker/choco-nuspec-checker_icon.png" width="139" height="88">

**BCURRAN3'S PACKAGE NOTES:**

* A BCURRAN3 original!
* I personally use and endorse this script. What started off as a script to automate changing image URLs in my packages to use CDN links has become a monster!
* In your header and footer files, if you want to add lines above and below your header and/or footer text like I do, I recommend using "___" for a line in markdown as apposed to "***" or "---". Chocolatey.org's package pages are fickle with "***" and "---" where sometimes the lines will be different shades of gray. "___" seems to consistently get displayed as a dark gray line. I've played with white space before and after "***" and "---" and I can't find any rhyme or reason to why I'll get a light gray line in one place and a dark gray line in another. I give up. "___" works.

---

### [choco://choco-nuspec-checker](choco://choco-nuspec-checker)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://chocolatey.org/packages/choco-protocol-support)

---
	
![Screenshot of (unofficial) Chocolatey .nuspec Checker (Script)](https://raw.githubusercontent.com/bcurran3/ChocolateyPackages/master/choco-nuspec-checker/choco-nuspec-checker_screenshot.png)

## **choco-nuspec-checker** (**CNC**) is a PowerShell script I designed for Chocolatey package maintainers/creators to check Chocolatey .nuspec files for common errors and omissions... and automatically fix most of them! Find out AND FIX what the Chocolatey validator is going to tell you BEFORE you submit your package. **CNC** also goes beyond it's original scope and checks for common Chocolatey install/uninstall script errors and omissions as well.

### FEATURES:
* **CNC** checks all .nuspec elements and reports any missing or template default values, now recursively too!
* **CNC** checks for all verifier messages (guidelines, suggestions, and notes) and reports them if applicable
* **CNC** checks for dead URLs and reports them
* **CNC** checks for GitHub direct links, reports them, and can convert them to various CDN URLs (default=Staticaly)
* **CNC** checks for RawGit CDN links, reports them, and can convert them to various CDN URLs (default=Staticaly)
* **CNC** can open all your .nuspec element URLs in your default browser for quick viewing
* **CNC** checks and reports current status of your package on chocolatey.org
* **CNC** can add a standard template header, footer, and/or package notes to your .nuspec description with variables
* **CNC** checks nuspec and PowerShell scripts for correct UTF-8 encoding and reports if the encoding is incorrect
* **CNC** can re-write your nuspec in UTF-8 w/o BOM format
* **CNC** can re-write your PowerShell scripts in UTF-8 w/ BOM format
* **CNC** checks all your PowerShell scripts for syntax errors
* **CNC** checks chocolateyInstall.ps1 for improper use of Install-ChocolateyPackage and Install-ChocolateyZipPackage when binaries are included
* **CNC** checks for and can add $ErrorActionPreference = 'Stop' to your PowerShell scripts
* **CNC** can optimize PNG files in your nuspec directory if PNGOptimizer.commandline is installed
* **CNC** can be run from the Command Prompt AND PowerShell
* **CNC** and more...

### Helps make packaging Chocolateasy!

### INSTRUCTIONS:
* **CNC -help** for help with options and switches
* Run **CNC** to check the .nuspec in your current directory or run **CNC X:\SOMEWHERE** to check the .nuspec in that directory. (Do not specify the file, just the directory.)

**[PACKAGE NOTES](https://github.com/bcurran3/ChocolateyPackages/blob/master/choco-nuspec-checker/readme.md)**

**If you find choco-nuspec-checker useful please consider donating: https://www.paypal.me/bcurran3donations or become a patron at https://www.patreon.com/bcurran3**
	
### CHANGELOG:
* 2023.05.17 - CNC now returns a non-zero exit code if there are any required changes and displays the total required changes of all nuspec files when the -Recurse switch is used
* 2023.05.15 - display # of characters when description is >4000, more specific template value checking, fix empty/missing files element message, skip dimension checking of SVG files, prep for moving some options to config file, added TheCakeIsNaOH's (Thanks!) move args to params and add help comments merge, minor updates to package URL checking and noficiations, no longer checks URLs with variables baked in, don't display PS error when non-image icon files are downloaded, less false positives checking for sourceforge and fosshub links in chocolateyinstall.ps1, updated markdown checking to display error line(s), checks chocolateyinstall.ps1 for improper use of Install-ChocolateyPackage and Install-ChocolateyZipPackage when binaries are included, new -ReduceOutput option to only show problems/errors (no blue or green informational messages), checks chocolateyinstall.ps1 for use of checksums, added checking for private enviroment variables, reports when http instead of https links are used, fixed bug where releaseNotes wasn't being checked for invalid Markdown
* 2020.09.20 - An AddPackageNotes feature has been added, works the same as the AddHeader and AddFooter options. Updated nuspec URL errors as requirements to be fixed. Added "PackageInternalFilesIncluded" checking. Minor cosmetic updates.
* 2020.09.15 - CNC will now ignore update.ps1 files.
* 2020.04.06.0001 - Updated CNC.cmd for ChocolateyToolsLocation handling. Fixed markdown heading error in CNCHeader.txt.
* 2020.04.06 - Better error handling when $env:ChocolateyToolsLocation is not defined. (Usually due to running under a different account than installed from.)
* 2020.01.16 - Updated message related to Markdown heading issues (now a requirement to fix), added Operating System index files checking, added verification that $env:ChocolateyToolsLocation exists (variable, not location)
* 2019.12.14 - Added checking for Markdown heading declarations that are incompatible with the Sept. 2019 changes to chocolatey.org. (Plan to autofix in a future update.)
* 2019.09.01 - Added Powershell v3 as a dependency due to Invoke-WebRequest use. Eliminated iwr error for new packages that weren't pushed to chocolatey.org yet, added reporting for packages that are in submitted or waiting for maintainer status, added to the common problems for not a valid XML file messages.
* 2019.08.26 - "Kicked out of bin release" - script installation endpoint changed. **Now works from Command Prompt as well as PowerShell.** Additional 7Zip supported formats checked for as binaries.
* 2019.08.22 - -UpdateXMLNamespace implemented (unreleased due to new moderation demands)
* 2019.08.21 - added checking for package release notes in description (unreleased due to new moderation demands)
* 2019.08.14 - now validates the nuspec as a valid XML file and reports common errors, notifies if there is a submitted/unapproved version on chocolatey.org, better checking for failed and trusted package notifications (unreleased due to new moderation demands)
* 2019.08.13 - minor fix to cinst checking in chocolateyinstall.ps1 (unreleased due to new moderation demands)
* 2019.03.04 - now checks for msiexec calls in scripts, checks for correctly named install script, checks that install scripts don't use choco commands, checks the XML namespace/schema, cosmetic changes
* 2019.02.22 - now notifies if the package is trusted and if the package is failing tests on chocolatey.org, -OptimizePNGs superseded by -OptimizeImages which will now optimize BMP, GIF, and TGA files as well as PNG files, added checking for FossHub download links in chocolateyInstall.ps1, more minor tweaks
* 2019.02.18 - now checks download URLs in install scripts, minor message updates
* 2019.02.16 - -UpdateScripts will re-write PowerShell scripts to UTF-8 w/BOM (even if EAP statement doesn't need to be added), now checks for and reports templated values, adding the XML UTF-8 check comment now implemented, more updates to summary, added checking for SourceForge download links in chocolateyInstall.ps1, -MakeBackups option to create *.CNC.bak files - this is a breaking change from v2019.01.29 where making backups was default, check for CDATA in description and parse it for problems but not change it when saving, some more tweaks that I forgot before writing this
* 2019.02.04 - New -UpdateScripts will add EAP statement to script files and re-write out to UTF-8 w/BOM, New -UseGitHack, -UseGitCDN, and -UsejsDelivr allows you to use image CDNs other than Staticaly (default), **CNC** now gives a summary count of warnings and fixes, now checks for header/footer before adding so duplicates aren't created, now checks all PowerShell scripts (previously only chocolateyinstall/uninstall), cosmetic changes to highlight required changes
* 2019.01.29 - you can now use the following tokens in your header and footer files: $NuspecAuthors, $NuspecID, $NuspecOwners, $NuspecTitle, and $NuspecVersion - they will be parsed and replaced with the values from your nuspec file, added checking iconUrl image dimensions, new -OptimizePNGs option to run PNGOptimizerCL (if installed via Chocolatey) on PNG files in nuspec dir, added checking for lack of BOM in install/uninstall scripts, added checking for $ErrorActionPreference statement in install/uninstall scripts, now aborts when there are multiple nuspec files found in the same directory, now aborts if nuspec appears corrupt, cosmetic enhancements, now makes a backup file upon updates.
* 2019.01.26 - "Birthday Release" **CNC is now considered "Ready for Prime Time."** (I still have more updates planned.) **CNC** can now write changes to your nuspec file including the iconUrl, description, and XML declaration (Finally!!!), added ability to update the XML declaration, added -UpdateAll and -Update options, updates are written as UTF-8 w/o BOM, cleaned up UTF-8 reporting, added PowerShell syntax error checking of chocolateyInstall.ps1 and chocolateyUninstall.ps1, new -WhatIf option for testing without saving changes, the normal minor tweaks and cosmetic changes. I will keep making it better though, of course.
* 2019.01.22 - added XML declaration and UTF-8 comment checking, better dependency version checking, a rare verifier message I missed
* 2019.01.15 - you can now specify a path to a directory containing a .nuspec file to check, misc minor tweaks
* 2019.01.13 - finished the dependencies checking, all verifier messages (guidelines, suggestions, and notes) now reporting in **CNC**
* 2019.01.12 - minor fixes
* 2019.01.09 - many more checks and warnings added, almost all known verifier guidelines, suggestions and notes added, some beautifications, added option to view Chocolatey validator info page, added optional image GitHub direct and RawGit URL conversions to Staticaly CDN URLs
* 2019.01.07 - added help, added option to open and view all URLs in your default browser, added options to view, edit, and add "standard" (template) headers and footers to the description (can't save yet), added reporting of standard header and footer if found, added more verifier messages, added checking for descriptions that are too large (&gt;4,000), now checks for license files other than LICENSE.txt, probably more I don't remember :)
* 2019.01.04 - implemented included binary files checking and messages, laid out the groundwork for the future enhancements
* 2019.01.03 - fixed some URL checking handling that could cause PS errors, updated list of CDN recommendations, added checking for RawGit URLs in description, cosmetic updates
* 2018.12.22-2018-12.28 - initial release

### ROADMAP:
* native recurse option
* Check validity of URLs in description, checked by the package verifier as of 01/11/2020
* Reformat invalid Markdown headings automagically
* Could use a CNC...not updated...-WhatIf message when -UpdateXMLNamespace and -WhatIf are used
* https://github.com/chocolatey/package-validator/wiki/PackageInternalFilesIncluded -started
* option of displaying useful tips and tweaks (AutoHotKey, BeCyIconGrabber, PngOptimizer, Regshot, service viewer program, Sumo, etc)
* MAYBE do full params statement and get rid of args checking - low priority
* MAYBE check http links to see if https links are available and report if so - low priority
* MAYBE edit and re-write handling CDATA in description (not sure if there is a need)
* https://github.com/chocolatey/package-validator/wiki/ChecksumShouldBeUsed
* add packaging tips/tweaks/etc
* What else? (PRs accepted)

***

Like my [original Chocolatey add-ons and packages](https://community.chocolatey.org/packages?q=tag%3Abcurran3)? or my [400+ other program packages](https://chocolatey.org/profiles/bcurran3)? Find them useful? Appreciate my hard work, time, and effort?


<h1>How about buying me a <img src="https://cdn.rawgit.com/bcurran3/ChocolateyPackages/master/mylogos/beer.png" alt="" width="40" height="40"> via PayPal?</h1>

[![PayPal Donate](https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg)](https://www.paypal.me/bcurran3donations)

<h1>Better yet... Keep me incentivized by Patreonizing me!</h1>

[![Patreonize me!](https://c5.patreon.com/external/logo/downloads_wordmark_white_on_coral.png)](https://www.patreon.com/bcurran3)


If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Bill</h3>

