$ErrorActionPreference = 'Stop'
# chocolatey-fastanswers.extension v0.0.2 by Bill Curran AKA BCURRAN3 - public domain

function Get-IsMobile{
$HasBattery=(Get-WmiObject win32_portablebattery)
 if ($HasBattery) {return $true} else {return $false}
}
