$packageName    = 'netdrive'
$global:packageMaintainer = 'BCURRAN3'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://files.bdrive.com/netdrive/builds/13661b2db8824158b7d3056d552ea90c/NetDrive3_Setup-3.5.434.exe' 
$checksum       = 'F2F2E6060F485B7EACF17D7D829477703A8EC9FD9B7B6D4D47047CF1E146367B'
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

Show-Patreon "https://www.patreon.com/bcurran3"
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
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."

Remove-Item $extractDir -recurse | out-null
