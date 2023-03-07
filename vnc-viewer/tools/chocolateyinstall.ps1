# https://www.realvnc.com/en/connect/download/viewer/
$ErrorActionPreference = 'Stop'
$packageName    = 'vnc-viewer'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$extractDir     = "$toolsDir\extracted"
$url            = "https://downloads.realvnc.com/download/file/viewer.files/VNC-Viewer-$env:ChocolateyPackageVersion-Windows-msi.zip"
$checksum       = 'DAAF020DAB60239C251AAC09F201A91510185C2F339E7F04249F921E3774A8B4'

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
