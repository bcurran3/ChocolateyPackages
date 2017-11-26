$packageName    = 'netdrive'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://files.bdrive.com/netdrive/builds/NetDrive3_Setup-3.1.234.exe' 
$checksum       = '9EF28FF671B13AE24A75B2C84E1968B77F14006E8E1088392FDF999AA38521AE'
$silentArgs     = "/quiet /qn /norestart"
$validExitCodes = @(0,1223)
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
  packageName   = $packageName
  fileType      = 'MSI'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'NetDrive*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item $extractDir -recurse | out-null
