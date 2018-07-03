$ErrorActionPreference = 'Stop'
$packageName    = '3dmark' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://akamai-dl.futuremark.com.akamaized.net/3DMark-v2-5-5029.zip'
$checksum       = '17A8DE629CFCCB1965DCC08F3E2795529B1939E824D336D8D7A8E09804094DEC'
$silentArgs     = '/S'
$validExitCodes = @(0)
$fileLocation   = "$toolsDir\3dmark-setup.exe"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = '3DMark*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item "$toolsDir\*.exe" | out-null
Remove-Item "$toolsDir\*.dlc" | out-null
Remove-Item "$toolsDir\*.msi" | out-null
Remove-Item "$toolsDir\redist" -recurse | out-null
Start-WaitandStop "FMSISvc"
