# download page without login - https://www.realvnc.com/en/connect/download/vnc/
$packageName    = 'vnc-connect'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$extractDir     = "$toolsDir\extracted"
$url            = 'https://www.realvnc.com/download/file/vnc.files/VNC-Server-6.3.2-Windows-msi.zip'
$checksum       = 'BBCEA0F66981B9E22AD38FE5B70E3C49B0BD7ED2C20036607EB535502C56EB25'


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
