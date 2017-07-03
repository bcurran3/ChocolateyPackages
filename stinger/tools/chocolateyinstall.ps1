$ErrorActionPreference = 'Stop'
$packageName      = 'stinger' 
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger32.exe'
$checksum         = 'E9DBAEBA8868087D9471D1A2234907DD8A9E4589CA52D6C544CCA5D3CC32BF29'
$url64            = 'http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger64.exe'
$checksum64       = '28F87A4A8017EC742F774C238D495F76096DBC29948CDDCAA406E51708CBD327'
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