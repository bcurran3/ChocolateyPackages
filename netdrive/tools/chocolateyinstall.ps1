$ErrorActionPreference = 'Stop'
$packageName    = 'netdrive'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://files.bdrive.com/netdrive/builds/518f50b3a4e84375880683e61130f9d4/NetDrive3_Setup-3.8.921.exe' 
$checksum       = '4C1418F7E9CD2A3E6CBE806BA73C2A414F54E266D8D72707E5B774977CCDE13A'
$extractDir     = "$toolsDir\extracted"
$fileLocation   = "$extractDir\NetDrive3.msi"

New-Item $extractDir -type directory

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $extractDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  file           = $fileLocation
  silentArgs     = '/quiet /qn /norestart'
  validExitCodes = @(0,1223)
  softwareName   = 'NetDrive*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item $extractDir -Recurse | Out-Null
