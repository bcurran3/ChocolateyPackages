$packageName    = 'vnc-viewer-plus'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.realvnc.com/download/file/viewerplus.files/vnc-viewer-plus-VP1_2_9-x86_win32.exe'
$checksum       = '415F2B6B47BAA8ABBC5C80047E88A384531BDD274C2CFDD0BDAE09FDD134D75E'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'AllWemo*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
