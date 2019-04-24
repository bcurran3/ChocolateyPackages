$ErrorActionPreference = 'Stop'
$packageName= 'hardware-identify.portable'
$installerType = 'ZIP'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.tweaking.com/files/setups/tweaking.com_hardware_identify_portable.zip' 
$checksum   = 'E9C3DED380F1B3562F6AF65221EF07D956F7D4DD152F2913CFC2E657F091455A'


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\Hardware Identify.lnk" -targetPath "$ToolsDir\HardwareIdentify.exe"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Hardware Identify.lnk" -targetPath "$ToolsDir\HardwareIdentify.exe"
