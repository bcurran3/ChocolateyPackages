$ErrorActionPreference = 'Stop'
$packageName      = 'stinger' 
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger32.exe'
$url64            = 'http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger64.exe'
$scriptDir        = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$ExeFile          = 'stinger32.exe'
$ExeFile64        = 'stinger64.exe'
$ShortcutName     = 'McAfee Stinger'
$processor        = Get-WmiObject Win32_Processor
$is64bit          = $processor.AddressWidth -eq 64

if($is64bit) {
   $installerPackage = Join-Path $scriptDir $ExeFile64
 } else {
   $installerPackage = Join-Path $scriptDir $ExeFile
 }

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64
  FileFullPath  = $installerPackage
  softwareName  = ''
  checksum      = 'EC02FE983D3ADBB1B74A8AB27564A2D189D3017D74E27C66C27A5F10730CFC2E'
  checksumType  = 'sha256'
  checksum64    = '19A066FC1FCD567CC6B70A4E471E6427969C9B5E3A79CA0D8E8340FBA4BBF012'
  checksumType64= 'sha256'
  }

Get-ChocolateyWebFile @packageArgs

if($is64bit) {
   Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\McAfee Stinger.lnk" -targetPath "$toolsDir\$ExeFile64" -WorkingDirectory "$toolsDir\$packageName"
   Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\McAfee Stinger.lnk" -targetPath "$toolsDir\$ExeFile64" -WorkingDirectory "$toolsDir\$packageName"
 } else {
   Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\McAfee Stinger.lnk" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir\$packageName"
   Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\McAfee Stinger.lnk" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir\$packageName"
 }