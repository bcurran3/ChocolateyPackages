$packageName    = 'google-drive-file-stream' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = https://dl.google.com/drive-file-stream/GoogleDriveFSSetup.exe
$checksum       = 'C720309D6749A924A9AF3D244EDBD787D467CD3AC31C6E1C55140B8AD2D9A1A6'
$silentArgs     = '--silent'
$validExitCodes = @(0)


$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'exe' 
  url            = $url
  silentArgs     = $silentArgs
  softwareName   = 'Drive File Stream'
  checksum       = $checksum
  checksumType   = 'sha256'  
  validExitCodes = $validExitCodes
  }
  
Install-ChocolateyPackage @packageArgs
