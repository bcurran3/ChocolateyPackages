#http://www.allware.com.mx/Doc.aspx?D=177&dn=AllWemo_2_14_setup.zip
$packageName    = 'allwemo'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\AllWemo.msi" 
$checksum       = '2B3558D9B74C3D51B3AE716C00C89A174755F14A3A0876FD33B04417E1D50917'
$silentArgs     = '/quiet /qn /norestart'
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
  
