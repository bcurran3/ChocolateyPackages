$ErrorActionPreference = 'Stop'
$packageName  = 'office2019-pro' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\office2019_install.ahk"
$url          = 'https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/en-US/Professional2019Retail.img'
$checksum     = '57BE67FFC089F54846F12404731778906248DF6486BD1901F5115C4FC8A626D9'
$FileFullpath = "$ToolsDir\Professional2019Retail.img"

# Will most likely need to update for Windows Server 2019 soon
if (!(Get-IsWin10) -or (Get-IsWinServer2016)){
   Write-Warning " ** Office 2019 only supports Windows 10 and Windows Server 2016"
   throw
  }

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'ISO'
  url           = $url
  FileFullPath  = $FileFullpath
  checksum      = $checksum
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$iso = Get-Item $FileFullPath
Mount-DiskImage -ImagePath $iso
$isodriveLetter = (Get-DiskImage $iso | Get-Volume).DriveLetter

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = "${isodriveLetter}:\Setup.exe"
  silentArgs    = ''
  validExitCodes= @(0)
  softwareName  = 'Microsoft Office 2019*'
}

Start-Process $ahkExe $ahkFile
Install-ChocolateyInstallPackage @packageArgs

# Probably need a while loop for OfficeC2RClient.exe or autohotkey
#Dismount-DiskImage -ImagePath $iso
#Remote-Item $FileFullPath -Force | Out-Null

# NOTES:
# https://techhelpday.com/microsoft-office-2019/
#