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
  checksum      = 'CE64F8D28CBB3E6F585E644CEFCEB96E9C98CF00E14960D4C0C1300D559E3918'
  checksumType  = 'sha256'
  checksum64    = '5A8932CBF4EF8D90E8FC470A9B64A93491C784CD4923F50232416AB4BE6FE848'
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