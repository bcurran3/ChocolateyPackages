$packageName    = 'vnc-viewer-plus'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.realvnc.com/download/file/viewerplus.files/vnc-viewer-plus-VP1_2_11-x86_win32.exe'
$checksum       = '90A8495597F8AFBEF125DE3D7BB6172F6F3ECB7DBE2AD5FA7143A41964129A86'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'VNC Viewer Plus*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
