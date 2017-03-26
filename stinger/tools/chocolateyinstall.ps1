$ErrorActionPreference = 'Stop'
$packageName      = 'stinger' 
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger32.exe'
$checksum         = 'B9B29DEB22B93D3D6961886778D94579737728BA7EC1442CB29A9A9318FD1FFE'
$url64            = 'http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger64.exe'
$checksum64       = '1DBDCFDFD49F4556D92C51BD7A32AA0FA385EF34A6B9C8AE3004318A83C4A19C'
$ExeFile32        = 'stinger32.exe'
$ExeFile64        = 'stinger64.exe'
$ShortcutName     = 'McAfee Stinger'

if (Get-OSArchitectureWidth -eq 64)
   {
    $installerPackage = Join-Path $toolsDir $ExeFile64
   } else {
    $installerPackage = Join-Path $toolsDir $ExeFile32
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

if (Get-OSArchitectureWidth -eq 64)
    {
     Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$toolsDir\$ExeFile64" -WorkingDirectory "$toolsDir\$packageName"
     Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\McAfee Stinger.lnk" -targetPath "$toolsDir\$ExeFile64" -WorkingDirectory "$toolsDir\$packageName"
    } else {
     Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$toolsDir\$ExeFile32" -WorkingDirectory "$toolsDir\$packageName"
     Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\McAfee Stinger.lnk" -targetPath "$toolsDir\$ExeFile32" -WorkingDirectory "$toolsDir\$packageName"
    }