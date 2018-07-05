$packageName    = 'vnc-connect'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.realvnc.com/download/file/vnc.files/VNC-Server-6.3.0-Windows-msi.zip'
$checksum       = '349D894808E91D4F1EF1220CED5CD41CDEFC22F5BD774F5C43629A5F9603DC1A'
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
    $Installer = "$extractDir\VNC-Server-6.3.0-Windows-en-64bit.msi"
   } else {
    $Installer = "$extractDir\VNC-Server-6.3.0-Windows-en-32bit.msi"
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