$packageName    = 'netdrive'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://files.bdrive.com/netdrive/builds/NetDrive3_Setup-3.1.218.exe' 
$checksum       = '6ADFEC99D86A43E2B4CD864FC262BA00F6852DD2C1D70F8E6EFCEB2937D85FD1'
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
