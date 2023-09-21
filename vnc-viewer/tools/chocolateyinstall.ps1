# https://www.realvnc.com/en/connect/download/viewer/
$ErrorActionPreference = 'Stop'
$packageName    = 'vnc-viewer'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$extractDir     = "$toolsDir\extracted"
$url            = "https://downloads.realvnc.com/download/file/viewer.files/VNC-Viewer-$env:ChocolateyPackageVersion-Windows-msi.zip"
$checksum       = '625488C08D64B5BCAE23625D2BF0D7AF92BF9BAFB5FB37D07BE7EAE0F389BC2C'

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
    $Installer = "$extractDir\VNC-Viewer-"+$ENV:packageVersion+"-Windows-en-64bit.msi"
   } else {
    $Installer = "$extractDir\VNC-Viewer-"+$ENV:packageVersion+"-Windows-en-32bit.msi"
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
# Remove portable version from packages versions 6.18.907 -  6.19.325
Remove-Item "$toolsDir\VNC-Viewer.exe" -Force -ErrorAction SilentlyContinue | Out-Null
Remove-Item "$ENV:PUBLIC\Desktop\VNC Viewer.lnk" -Force -ErrorAction SilentlyContinue | Out-Null
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\VNC Viewer" -Force -ErrorAction SilentlyContinue | Out-Null

# UPDATE INSTRUCTIONS:
# Update checksum