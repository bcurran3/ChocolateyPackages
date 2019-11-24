$ErrorActionPreference = 'Stop'
$packageName    = 'intel-proset-drivers' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzippedfiles"
$bits           = Get-ProcessorBits
$url            = 'https://downloadmirror.intel.com/29003/a08/WiFi_21.30.3_Driver32_Win10.exe'
$checksum       = 'B99D12F6AEB6E6D210EB3C630DA0CF84B2D49772DA2C44C4E8051E72B070CD38'
$url64          = 'https://downloadmirror.intel.com/29003/a08/WiFi_21.30.3_Driver64_Win10.exe'
$checksum64     = 'A343C316F9E918CC8BC31A219F47B30424338D828B77A93603386DA243BE367A'

# Verify Windows 10 and throw if not
if (!(Test-Dependency "dependency-windows10")) {throw}

# No need to check for hardware, drivers install even if an Intel PROSet/Wireless card is not found

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64    
  checksum64     = $checksum64  
  checksumType64 = 'sha256'  
}

#Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$unzipLocation\Setup.exe"
  silentArgs     = '-q -passive -norestart'
  validExitCodes = @(0)
  softwareName   = 'Intel® PROSet/Wireless Software'
}
 
Install-ChocolateyInstallPackage @packageArgs

Start-Sleep -s 10

Remove-Item $unzipLocation -Recurse | Out-Null
