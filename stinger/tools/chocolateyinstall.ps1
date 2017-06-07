$ErrorActionPreference = 'Stop'
$packageName      = 'stinger' 
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger32.exe'
$checksum         = '95A47FAB631DC63B7F9E53537732B9C17E86D335BFD36F75195601CF36F252C9'
$url64            = 'http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger64.exe'
$checksum64       = '6CA123610EA33959090B77763E4A41AD1FC74B6C7E4DEE743123809E0E50AE22'
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