# chocolatey-misc-helpers.extension v0.0.3 (12-04-2018) by Bill Curran - public domain
# Creates a .pin file in \programdata\chocolatey\.chocolatey\packagename.packageversion folder to AutoPin a package
# Implementation should be via a user opt-in installation package parameter; i.e. AUTOPIN:YES
# REF: https://github.com/chocolatey/choco/issues/1607
# DISCLAIMER: Enable-AutoPin is implemented via an undocumented/non-public/unofficial "API." Tested with Chocolatey v0.10.11, should work with Chocolatey v0.9.9-v0.10.11. This will be depracated when a future version of Chocolatey switches to using a database to store package options and thus this method will stop working. 

function Enable-AutoPin{
if ((!($env:ChocolateyPackageName)) -or (!($env:ChocolateyPackageVersion))) {return}
if (Test-Path -Path $env:ChocolateyInstall\.chocolatey\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion){
    Write-Output "This package has been AutoPinned." > "$env:ChocolateyInstall\.chocolatey\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion\.pin"
	Write-Host "  ** $env:ChocolateyPackageName v$env:ChocolateyPackageVersion AutoPinned." -foreground green
   } 
}
