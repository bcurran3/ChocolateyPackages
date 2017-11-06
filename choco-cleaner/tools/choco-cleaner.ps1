# choco-cleaner.ps1 v0.0.1 by Bill Curran 11/06/2017
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue if you have a suggestion/request.
Remove-Item -path $env:chocolateyinstall\logs\* -recurse -exclude chocolatey.log,choco.summary.log -ErrorAction SilentlyContinue
Remove-Item -path $env:chocolateyinstall\* -recurse -include *.msi,*.zip -ErrorAction SilentlyContinue
Remove-Item -path $env:chocolateyinstall\* -recurse -include *.msi.ignore,*.zip.txt,*.exe.txt -ErrorAction SilentlyContinue
Remove-Item -path $env:chocolateyinstall\* -recurse -include credits.txt,readme.txt,*.md -ErrorAction SilentlyContinue
Remove-Item -path $env:chocolateyinstall\* -recurse -include *.old -ErrorAction SilentlyContinue
Remove-Item -path $env:chocolateyinstall\chocolatey\config\chocolatey.config.backup -ErrorAction SilentlyContinue
Remove-Item -path $env:chocolateyinstall\bin\_processed.txt -ErrorAction SilentlyContinue
Remove-Item -path $env:chocolateyinstall\lib-bad\* -recurse -ErrorAction SilentlyContinue
Remove-Item -path $env:chocolateyinstall\lib-bkp\* -recurse -ErrorAction SilentlyContinue
####### DESCRETIONARY DELETIONS BELOW: #######
#If you are an organization with software license audits, you probably want to comment out the line below:
Remove-Item -path $env:chocolateyinstall\* -recurse -include license.txt,*.license.txt,verification.txt -exclude shimgen.license.txt -ErrorAction SilentlyContinue
#If cacheLocation in chocolatey.config has NOT been changed...
Remove-Item -path $env:tmp\chocolatey\* -recurse -ErrorAction SilentlyContinue
Remove-Item -path $env:tmp\temp\chocolatey\* -recurse -ErrorAction SilentlyContinue
Write-Host choco-cleaner finished deleting unnecessary Chocolatey files! -foreground magenta
exit


#######################################################################################################################
You can comment out anything above that you do not want to delete such as log or license files with a "#" at the front of the line.

LEGEND:
* .log files that are not the most current one
* .msi and .zip files left over from packages that forgot to delete them post install
* .msi.ignore files created to ignore the .msi file for shimming - not needed as we are deleting the .msi files
* .zip.txt and .exe.txt files are lists of files that were extracted from an archive file for installation
* credits.txt are credits files you can read on the web
* readme.txt files you can read on the web
* .md files are usually markdown readme files that you can read on the web
* .old files are Chocolatey files that have been replaced by newer ones (exe's and dll's mostly)
* chocolatey.config.backup is a backup of your chocolatey.config file
* _processed.txt - I have no idea what made this file
* lib-bad holds packages that failed to install and lib-bkp contains aborted packages (during updates?) 
* \Users\username\AppData\Local\Temp\chocolatey is where new package files are downloaded to
* \Users\username\AppData\Local\Chocolatey similar to above
* license.txt and verification.txt files are included when packages include binaries, you can read them on the package web page
* programname.license.txt files are license information for Chocolatey default tools
#######################################################################################################################