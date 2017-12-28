$packageName    = 'vnc-connect'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.realvnc.com/download/file/vnc.files/VNC-Server-6.2.1-Windows-msi.zip'
$checksum       = '2AF7702759372BBADB05EE4E5664D5D40C88B5DFD48782B623B30C9FB6B5CC1E'
$silentArgs     = "/quiet /qn /norestart"
$validExitCodes = @(0, 3010, 1641)
$bits           = Get-ProcessorBits
$extractDir     = "$toolsDir\extracted"

New-Item $extractDir -type directory -force

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $extractDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

if ($bits -eq 64)
   {
    $Installer = "$extractDir\VNC-Server-6.2.1-Windows-en-64bit.msi"
   } else {
    $Installer = "$extractDir\VNC-Server-6.2.1-Windows-en-32bit.msi"
   }

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  file          = $Installer
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'VNC *'
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item $extractDir -recurse -force | out-null