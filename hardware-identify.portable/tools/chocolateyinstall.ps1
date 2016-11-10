$ErrorActionPreference = 'Stop'
$packageName= 'hardware-identify.portable'
$installerType = 'ZIP'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.tweaking.com/files/setups/tweaking.com_hardware_identify_portable.zip' 
$checksum   = 'B0F94563267737E8B32FBCB1068ED56CD5E7F6B5E733C0A4BE99558CA50B4B7E'


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Hardware Identify.lnk" -targetPath "$ToolsDir\HardwareIdentify.exe"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Hardware Identify.lnk" -targetPath "$ToolsDir\HardwareIdentify.exe"

  
