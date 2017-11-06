# choco-cleaner.ps1 v0.0.1 by Bill Curran
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open to suggestions - open a GitHub issue please if you have a suggestion/request.
#Remove-Item -path $env:chocolateyinstall\.chocolatey\* -recurse -whatif
Remove-Item -path $env:chocolateyinstall\logs\* -recurse -exclude chocolatey.log,choco.summary.log -whatif
Remove-Item -path $env:chocolateyinstall\* -recurse -include *.msi,*.zip -whatif
Remove-Item -path $env:chocolateyinstall\* -recurse -include *.msi.ignore,*.zip.txt,*.exe.txt -whatif
Remove-Item -path $env:chocolateyinstall\* -recurse -include credits.txt,license.txt,*.license.txt,verification.txt,readme.txt,*.md -whatif
Remove-Item -path $env:chocolateyinstall\bin\_processed.txt -whatif
Remove-Item -path $env:chocolateyinstall\* -recurse -include *.old -whatif
#Remove-Item -path $env:chocolateyinstall\* -recurse -include *.backup -whatif
#Remove-Item -path $env:chocolateyinstall\* -recurse -include *.txt -whatif
#
#Remove-Item -path $env:chocolateyinstall\lib-bad\* -recurse -whatif
#Remove-Item -path $env:chocolateyinstall\lib-bkp\* -recurse -whatif
#
#if cacheLocation in chocolatey.config hasn't been changed.
#Remove-Item -path $env:tmp\chocolatey\* -recurse -whatif
#Remove-Item -path $env:tmp\temp\chocolatey\* -recurse -whatif
exit

#######################################################################################################################
You can comment out anything above you do not want to delete such as log files with a "#" at the front of the line.

LEGEND:
* log files that are not the most current one
* msi and zip files that are left over from packages that forgot to delete them post install
* msi.ignore files created to ignore the file for shimming, but we just deleted the msi files
* zip.txt and exe.txt files are list of files that were extracted from an archive file
* license.txt and *.license.txt are license files that you can read on the web
* credits.txt are credits files you can read on the web
* license.txt and verification.txt files are included when packges have binaries, you can read them on the web
* programname.license.txt files are license information for Chocolatey tools
* readme.txt files you can read on the web
* md files are usually markdown read me's that you can read on the web
* old files are Chocolatey files that have been replaced by newer ones (exe's and dll's mostly)
* _processed.txt - I have no idea what made this file
* backup files are 
#######################################################################################################################