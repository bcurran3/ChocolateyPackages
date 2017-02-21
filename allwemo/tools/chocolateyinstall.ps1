#http://www.allware.com.mx/Doc.aspx?D=177&dn=AllWemo_2_14_setup.zip
#NOTE: Installed software reports v2.13 in Control Panel, not v2.14
$packageName    = 'allwemo'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\AllWemo.msi" 
$checksum       = '466FC0B3474E978B6C515C9A44F30DCC627D25FE0E5799AE12B84B70CDDCA2F2'
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