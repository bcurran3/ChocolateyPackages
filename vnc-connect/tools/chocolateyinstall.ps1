# download page without login - https://www.realvnc.com/en/connect/download/vnc/
$ErrorActionPreference = 'Stop'
$packageName    = 'vnc-connect'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$extractDir     = "$toolsDir\extracted"
$url            = "https://downloads.realvnc.com/download/file/vnc.files/VNC-Server-6.11.0-Windows-msi.zip"
$checksum       = 'A177B5FA9A2C15ADEB5C6D4676996054FC9DC58B3BDDDC919FA5315FD6AC3584'


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
    $Installer = "$extractDir\VNC-Server-6.11.0-Windows-en-64bit.msi"
   } else {
    $Installer = "$extractDir\VNC-Server-6.11.0-Windows-en-32bit.msi"
   }

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  file           = $Installer
  silentArgs     = '/quiet /qn /norestart'
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'VNC Server*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item $extractDir -Recurse -Force | Out-Null

# UPDATE INSTRUCTIONS:
# Update the checksum variable
