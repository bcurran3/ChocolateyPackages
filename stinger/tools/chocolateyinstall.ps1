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
  checksum      = '718E495AE34B1FEADF01C0B2197B0796FF7B8E1547933C89A7152344BEA56200'
  checksumType  = 'sha256'
  checksum64    = '799844A0D6442FD28EAAFAA002B15C9D45F1694E3A781305BECDE36A4C3F59ED'
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