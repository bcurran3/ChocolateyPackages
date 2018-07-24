$packageName    = 'vnc-connect'
$global:packageMaintainer = 'BCURRAN3'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.realvnc.com/download/file/vnc.files/VNC-Server-6.3.1-Windows-msi.zip'
$checksum       = 'B3F199A195E3B5510F07D33D175DBF55CB848A6E6ABA70CC75F70FD4E4F60917'
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
    $Installer = "$extractDir\VNC-Server-$env:packageVersion-Windows-en-64bit.msi"
   } else {
    $Installer = "$extractDir\VNC-Server-$env:packageVersion-Windows-en-32bit.msi"
   }

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  file          = $Installer
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'VNC Server*'
}
 
Show-Patreon "https://www.patreon.com/bcurran3"   
Install-ChocolateyInstallPackage @packageArgs
Show-ToastMessage "VNC Connect (Server) installed." "Version $env:packageVersion."

Remove-Item $extractDir -recurse -force | out-null