$ErrorActionPreference = 'Stop'
$packageName    = 'intel-network-drivers-win10' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$bits           = Get-ProcessorBits
$url            = 'https://downloadmirror.intel.com/25016/eng/PROWin32.zip'
$checksum       = 'C4B35D6C70CE5CFDF7C55A73E4C4E554FFAF07E23358D5CCEF4CAB4F55F033CD'
$url64          = 'https://downloadmirror.intel.com/25016/eng/PROWinx64.zip'
$checksum64     = '7F48BF346C92EA4EA7F615CF78E50D73F24D6BB0BE43516A7D7415228B858DDF'

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

$packageArgs = @{
  packageName    = $packageName
  Destination    = $unzipLocation
  FileFullPath   = "$unzipLocation\PROWin32.exe"
  FileFullPath64 = "$unzipLocation\PROWinx64.exe"
}

Get-ChocolateyUnzip @packageArgs


$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$unzipLocation\APPS\PROSETDX\Win32\DxSetup.exe"
  file64         = "$unzipLocation\APPS\PROSETDX\Winx64\DxSetup.exe"
  silentArgs     = '/qn'
  validExitCodes = @(0)
  softwareName   = 'Intel(R) Network Connections*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Start-Sleep -s 10

Remove-Item $unzipLocation -Recurse -EA SilentlyContinue | Out-Null
