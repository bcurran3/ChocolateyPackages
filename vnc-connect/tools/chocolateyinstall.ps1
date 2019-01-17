# download page without login - https://www.realvnc.com/en/connect/download/vnc/
$packageName    = 'vnc-connect'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$extractDir     = "$toolsDir\extracted"
$url            = 'https://www.realvnc.com/download/file/vnc.files/VNC-Server-6.4.0-Windows-msi.zip'
$checksum       = '624D64C8AD3DABEB8C38C37515D4F8215683ACC03CD7C89BF9F017145F60D6CD'


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
  packageName    = $packageName
  fileType       = 'MSI'
  file           = $Installer
  silentArgs     = '/quiet /qn /norestart'
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'VNC *'
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item $extractDir -Recurse -Force | Out-Null
