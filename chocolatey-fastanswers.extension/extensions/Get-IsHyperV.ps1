﻿$ErrorActionPreference = 'Stop'
# chocolatey-fastanswers.extension v0.0.2 by Bill Curran AKA BCURRAN3 - public domain

function Get-IsHyperV{
$IsHyperV=(Get-WmiObject Win32_ComputerSystem).Model
if ($IsHyperV -match "Virtual Machine") {return $true} else {return $false}
}
