$ErrorActionPreference = 'Stop'
$packageName      = 'stinger' 
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger32.exe'
$checksum         = 'A29B01C00EFEC9C6C4E24C9B0EBE1A8B9FC3656DA1384FC55753B446F04875CA'
$url64            = 'http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger64.exe'
$checksum64       = 'AFE135116A0BB7D36025D5BD0A4E9B65AA8A6D1A1D71BECBDC17AFF6DBBED8C4'
$ExeFile32        = 'stinger32.exe'
$ExeFile64        = 'stinger64.exe'
$ShortcutName     = 'McAfee Stinger'
$bits             = Get-ProcessorBits

if ($bits -eq 64)
   {
    $installerPackage = Join-Path $toolsDir $ExeFile64
	$ExeFile = $ExeFile64
   } else {
    $installerPackage = Join-Path $toolsDir $ExeFile32
	$ExeFile = $ExeFile32
 }

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'  
  FileFullPath  = $installerPackage
  softwareName  = ''
  }

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir\$packageName"
 Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\McAfee Stinger.lnk" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir\$packageName"
