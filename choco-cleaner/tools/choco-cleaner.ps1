# choco-cleaner.ps1 v0.0.1 by Bill Curran 11/06/2017
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue if you have a suggestion/request.
Write-Host Deleting unnecessary log files... -foreground magenta
Remove-Item -path $env:chocolateyinstall\logs\* -recurse -exclude chocolatey.log,choco.summary.log -ErrorAction SilentlyContinue
Write-Host Deleting unnecessary archive files... -foreground magenta
Remove-Item -path $env:chocolateyinstall\* -recurse -include *.zip,*.rar,*.7z,*.gz,*.tar,*.sfx,*.iso -ErrorAction SilentlyContinue
Write-Host Deleting unnecessary extracted file logs... -foreground magenta
Remove-Item -path $env:chocolateyinstall\* -recurse -include *.zip.txt,*.exe.txt,*.rar.txt,*.7z.txt,*.gz.txt,*.tar.txt,*.sfx.txt,*.iso.txt -ErrorAction SilentlyContinue
Write-Host Deleting unnecessary Microsoft installers... -foreground magenta
Remove-Item -path $env:chocolateyinstall\* -recurse -include *.msi,*.msu,*.msp -ErrorAction SilentlyContinue
Write-Host Deleting unnecessary .ignore files... -foreground magenta
Remove-Item -path $env:chocolateyinstall\* -recurse -include *.ignore -ErrorAction SilentlyContinue
Write-Host Deleting unnecessary various read me files... -foreground magenta
Remove-Item -path $env:chocolateyinstall\* -recurse -include credits.txt,readme.txt,*.md -ErrorAction SilentlyContinue
Write-Host Deleting unnecessary old Chocolatey files... -foreground magenta
Remove-Item -path $env:chocolateyinstall\* -recurse -include *.old -ErrorAction SilentlyContinue
Write-Host Deleting unnecessary config backup files... -foreground magenta
Remove-Item -path $env:chocolateyinstall\chocolatey\config\chocolatey.config.backup -ErrorAction SilentlyContinue
Write-Host "Deleting unnecessary _processed.txt (WTF?) file..." -foreground magenta
Remove-Item -path $env:chocolateyinstall\bin\_processed.txt -ErrorAction SilentlyContinue
Write-Host Deleting unnecessary lib-bad files... -foreground magenta
Remove-Item -path $env:chocolateyinstall\lib-bad\* -recurse -ErrorAction SilentlyContinue
Write-Host Deleting unnecessary lib-bkp files... -foreground magenta
Remove-Item -path $env:chocolateyinstall\lib-bkp\* -recurse -ErrorAction SilentlyContinue
Write-Host Deleting unnecessary archives and executibles in .nupkg files... -foreground magenta
dir $env:chocolateyinstall\lib -recurse -include *.nupkg | %{7z d -r -tZIP $_.FullName *.exe *.zip *.rar *.7z *.gz *.tar *.sfx *.iso *.msi *.msu *.msp} | Out-Null
#If cacheLocation in chocolatey.config has NOT been changed (most people)...
Write-Host Deleting unnecessary cache files... -foreground magenta
Remove-Item -path $env:tmp\chocolatey\* -recurse -ErrorAction SilentlyContinue
####### DESCRETIONARY DELETIONS BELOW: #######
#If you are an organization with software license audits, you probably want to comment out the line below to NOT delete license files:
Write-Host Deleting unnecessary license files... -foreground magenta
Remove-Item -path $env:chocolateyinstall\* -recurse -include license.txt,*.license.txt,verification.txt -exclude shimgen.license.txt -ErrorAction SilentlyContinue
Write-Host choco-cleaner finished deleting unnecessary Chocolatey files! -foreground magenta
exit


#######################################################################################################################
# You can comment out anything above that you do not want to delete such as log or license files with a "#" at the front of the line.
# File deletion statements (Remove-Item) are purposely grouped for easy disabling based on types of files.
# 
# LEGEND:
# * .log files that are not the most current one
# * .zip, .rar, .iso, and various archive files left over from packages that forgot to delete them post install
# * .zip.txt and other archive-extensions.txt are lists of files that were extracted from an archive file for installation
# * .msi, .msu, and .msp are Microsoft intall packages left over from packages that forgot to delete them post install
# * .ignore files are created to not shim executables during package install but not needed after shim operations are finished (This may change in a # future version of Chocolatey.)
# * credits.txt are program credits (of contributors) files you can read on the web
# * readme.txt files you can read on the web
# * .md files are usually markdown readme files that you can read on the web
# * .old files are Chocolatey files that have been replaced by newer versions (exe's and dll's mostly)
# * chocolatey.config.backup is a backup of your chocolatey.config file
# * _processed.txt - I have no idea what made this file
# * lib-bad holds packages that failed to install and lib-bkp contains aborted packages (during updates?) 
# * .nuspkg files are ZIP archives with NuGet package information, included already installed binaries are not needed (similar to [Package Reducer](https://chocolatey.org/docs/features-package-reducer)
# * \Users\username\AppData\Local\Temp\chocolatey is where new package files are downloaded to during pre-installation (if you haven't changed your cacheLocation in chocolatey.config)
# * license.txt and verification.txt files are included when packages include binaries, you can read them on the package web page, programname.license.txt files are license information for Chocolatey default tools
#######################################################################################################################
