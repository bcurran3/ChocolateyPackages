$ErrorActionPreference = 'Stop'
$packageName      = 'stinger' 
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger32.exe'
$checksum         = '3F5F4ED3E15FB45674B4FEDFC840C51C8A4640FD96A4255A46552B2867215304'
$url64            = 'http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger64.exe'
$checksum64       = '436544E469A8E4F821388C50094675E5F7A668216317AEDB579DBF3F739A138A'
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