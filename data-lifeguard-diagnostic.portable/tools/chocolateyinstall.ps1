$ErrorActionPreference = 'Stop'
$packageName = 'data-lifeguard-diagnostic.portable'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://downloads.wdc.com/windlg/WinDlg_v1_36.zip'
$checksum    = 'CC6ADB8DDCADD7ECEEC9BBCAADA4ACD1921164C272D13E1AFE02F8E43AFB779B'
$exe         = "$toolsDir\WinDlg_v1_36.exe"
 
$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
}
 
Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = '/SILENT /NORESTART'
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = $checksumType 
}

Install-ChocolateyPackage @packageArgs
