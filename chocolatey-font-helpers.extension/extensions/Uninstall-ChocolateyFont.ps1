# chocolatey-font-helpers.extension v0.0.1 (07-24-2018) by Bill Curran - public domain
# Uninstall-ChocolateyFont.ps1 -uses Microsoft's Remove-Font.ps1 v1.0.1 Copyright (C) 2010 Microsoft Corporation
# Usage example: Uninstall-ChocolateyFont "FontName.ext"
# https://blogs.technet.microsoft.com/deploymentguys/2010/12/04/adding-and-removing-fonts-with-windows-powershell/

function Uninstall-ChocolateyFont($FontName)
{
 Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
 Set-Location "$env:ChocolateyInstall\extensions\chocolatey-font-helpers\MS"
 .\Remove-Font.ps1 $FontName
}