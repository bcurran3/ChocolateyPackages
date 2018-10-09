# download page without login - https://www.realvnc.com/en/connect/download/vnc/
$packageName    = 'vnc-connect'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$extractDir     = "$toolsDir\extracted"
$bits           = Get-ProcessorBits
$url            = 'https://www.realvnc.com/download/file/vnc.files/VNC-Server-6.3.1-Windows-msi.zip'
$checksum       = 'B3F199A195E3B5510F07D33D175DBF55CB848A6E6ABA70CC75F70FD4E4F60917'


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
    $Installer = "$extractDir\VNC-Server-$env:packageVersion-Windows-en-64bit.msi"
   } else {
    $Installer = "$extractDir\VNC-Server-$env:packageVersion-Windows-en-32bit.msi"
   }

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  file          = $Installer
  silentArgs    = '/quiet /qn /norestart'
  validExitCodes= @(0, 3010, 1641)
  softwareName  = 'VNC *'
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item $extractDir -recurse -force | out-null