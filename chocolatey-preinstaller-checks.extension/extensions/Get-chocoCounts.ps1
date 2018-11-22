# chocolatey-preinstaller-checks.extension v0.0.2-pre01 by Bill Curran AKA BCURRAN3 - 2018 public domain
# Get-chocoCounts.ps1 - reports instances of choco.exe back to Get-chocoStatus.ps1
# \ProgramData\chocolatey\bin\choco.exe (in path) IS a shim to \ProgramData\chocolatey\choco.exe actual (not in path)
# i.e. running choco.exe will always count as 2 instances
# all shims run choco.exe, so choco.exe count is +1 from the shim execution

function Get-chocoCounts{
$chocoInstances      = @(Get-Process -ea silentlycontinue choco).count #includes choco.exe shim
$chocolateyInstances = @(Get-Process -ea silentlycontinue chocolatey).count
$cinstInstances      = @(Get-Process -ea silentlycontinue cinst).count
$clistInstances      = @(Get-Process -ea silentlycontinue clist).count
$cpackInstances      = @(Get-Process -ea silentlycontinue cpack).count
$cpushInstances      = @(Get-Process -ea silentlycontinue cpush).count
$cuninstInstances    = @(Get-Process -ea silentlycontinue cuninst).count
$cupInstances        = @(Get-Process -ea silentlycontinue cup).count
$cverInstances       = @(Get-Process -ea silentlycontinue cver).count
# add shims to false choco.exe count
$chocoInstances = ($chocoInstances +$chocolateyInstances +$cinstInstances +$clistInstances +$cpackInstances +$cpushInstances +$cuninstInstances +$cupInstances +$cverInstances)
# divide in half to remove shims from count and get real choco.exe instance count
$chocoInstances = $chocoInstances/2
return $chocoInstances
}