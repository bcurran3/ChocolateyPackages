$ErrorActionPreference = 'Stop'
$packageName    = 'intel-network-drivers-win10' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$bits           = Get-ProcessorBits
$url            = 'https://downloadmirror.intel.com/25016/eng/PROWin32.exe'
$checksum       = '1EB55DAC4FF6C9A3652829B04C585E77E3E760672783C1EF5043636FFD9ADE41'
$url64          = 'https://downloadmirror.intel.com/25016/eng/PROWinx64.exe'
$checksum64     = 'C4B12B57987492BBCD433758908D6913EB5504B2C667A7886CD18204E636F14E'

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

Install-ChocolateyZipPackage @packageArgs

if ($bits -eq 64)
   {
	$url = "$unzipLocation\APPS\PROSETDX\Winx64\DxSetup.exe"
   } else {
	$url = "$unzipLocation\APPS\PROSETDX\Win32\DxSetup.exe"
   }

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $url
  silentArgs     = '/qn'
  validExitCodes = @(0)
  softwareName   = 'Intel(R) Network Connections*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Start-Sleep -s 10

Remove-Item $unzipLocation -Recurse -EA SilentlyContinue | Out-Null
#Start-CheckandStop "AutoHotkey" - future use?
