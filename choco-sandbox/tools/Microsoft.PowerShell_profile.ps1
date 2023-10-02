# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
function cinst {choco install}
function cuninst {choco uninstall}
function cup {choco upgrade}
function clist {choco list}
function cweb {param ([string]$package ) 
if (($package -eq '') -or ($package -eq '.')) {$package=(Split-Path -Leaf $(Get-Location).Path)}
start https://community.chocolatey.org/packages/$package
}
