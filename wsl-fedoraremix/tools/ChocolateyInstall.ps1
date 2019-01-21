$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-fedoraremix'
$bits           = Get-ProcessorBits
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

if (!($bits -eq 64)){
    Write-Warning "  **  This package is for 64 bit versions of Windows only. Aborting..."
	throw
	}

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = "$toolsDir"
  fileType       = 'ZIP' 
  url            = "$toolsDir\DistroLauncher-Appx_1.0.26.0_x64.appxbundle"
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = "$toolsDir\distro"
  fileType       = 'ZIP' 
  url            = "$toolsDir\DistroLauncher-Appx_1.0.26.0_x64.appx"
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  softwareName   = ''
  fileType       = 'EXE'
  silentArgs     = 'install --root'
  file           = "$toolsDir\distro\fedoraremix.exe"
  validExitCodes = @(0,1)
  }

Install-ChocolateyInstallPackage @packageArgs

Install-BinFile -Name fedoraremix -Path "$toolsDir\distro\fedoraremix.exe"

$WhoAmI=whoami
icacls.exe "$toolsDir\distro" /grant $WhoAmI":"'(OI)(CI)'F /T | Out-Null

wslconfig /list
Write-Host "  ** To run Fedora Remix, type fedoraremix from the Command Prompt or PowerShell." -ForeGround Magenta

Remove-Item "$toolsDir\AppxMetadata" -Recurse -Force  -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\*.appx" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\*.appxbundle" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\*.p7x" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\*.xml" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\distro\AppxMetadata" -Recurse -Force  -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\distro\Assets" -Recurse -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\distro\*.p7x" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\distro\*.pri" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\distro\*.xml" -Force -EA SilentlyContinue | Out-Null
if (Test-Path "$ENV:ChocolateyInstall\lib\wsl-fedoraremix\tools\distro\rootfs\var\yp"){Remove-Item "$toolsDir\distro\*.gz" -Force -EA SilentlyContinue | Out-Null}
