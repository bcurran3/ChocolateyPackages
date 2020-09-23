$ErrorActionPreference = 'Stop'
$packageName   = 'searchwithmybrowser'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$toolsDir\SWMB-setup.exe"
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
  softwareName   = 'SearchWithMyBrowser*' 
}

New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ea SilentlyContinue | Out-Null
if (Test-Path -Path "HKCR:microsoft-edge") {
    Install-ChocolateyInstallPackage @packageArgs
	} else {
	  Write-Host "  ** Microsoft Edge not found or unsupported version of Windows" -ForeGround Red
	  throw
	  }
