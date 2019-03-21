$ErrorActionPreference = 'Stop'
$packageName    = 'intel-network-drivers-win10' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzippedfiles"
$bits           = Get-ProcessorBits
$url            = 'https://downloadmirror.intel.com/25016/eng/PROWin32.exe'
$checksum       = 'F7CBF8EC152B31F2AC10FF4865B54F16A24C618836A381358C072ECDA0680A73'
$url64          = 'https://downloadmirror.intel.com/25016/eng/PROWinx64.exe'
$checksum64     = 'FEB0C221737406A4859AEBC2C8D6F676EA9CC32619E1FAE46A3298546D0B4D57'


if (Get_IsIntelVideo)
  {
   Write-Host "Intel network adapter found." -Foreground Magenta
  } else {
   Write-Host "No Intel network adapters found. Aborting." -Foreground Red
   throw
   }

New-Item $unzipLocation -Type Directory | Out-Null

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

Remove-Item $unzipLocation -Recurse | Out-Null
