$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-archlinux'
$bits           = Get-ProcessorBits
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/bilguun0203/WSL-ArchLinux/releases/download/v1.0.3.0/ArchLinux-Appx_1.0.3.0_x64.zip'
$checksum       = '268D3E5140C42DB6767B779AC3CABF4EA60011383C4389A50F80B92F4FF3A1D5'
$unzipLocation  = $toolsDir
$exe            = 'arch.exe'

if (!($bits -eq 64)){
    Write-Warning "This package is for 64 bit versions of Windows only."
	throw
	}

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = "$toolsDir\DistroLauncher-Appx_1.0.3.0_x64.appx"
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  softwareName   = ''
  fileType       = 'EXE'
  silentArgs     = 'install --root'
  file           = "$toolsDir\$exe"
  validExitCodes = @(0)
  }

Install-ChocolateyInstallPackage @packageArgs
Install-BinFile -Name arch -Path $toolsDir\arch.exe
wslconfig /list

Remove-Item $toolsDir\DistroLauncher-Appx*.* -force | Out-Null
Remove-Item $toolsDir\Add-AppDevPackage.ps1 -force | Out-Null
Remove-Item $toolsDir\Add-AppDevPackage.resources -recurse -force | Out-Null
