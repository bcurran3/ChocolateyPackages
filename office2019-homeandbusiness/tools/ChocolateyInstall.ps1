$ErrorActionPreference = 'Stop'
$packageName  = 'office2019-homeandbusiness' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/en-US/HomeBusiness2019Retail.img'
$checksum     = '803E93581E991102ADFDDCB4E5CAC3B60CE9E4A28ED501F11F86CB19EB003A8D'
$FileFullpath = "$ToolsDir\HomeBusiness2019Retail.img"

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

Install-ChocolateyInstallPackage @packageArgs

# I still need to check for the installation to finish (AHK) and wait before running the following:
#Dismount-DiskImage -ImagePath $iso
#Remote-Item $FileFullPath -Force | Out-Null