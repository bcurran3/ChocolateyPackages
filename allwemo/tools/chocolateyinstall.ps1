# https://ea.im/Doc.aspx?D=206&dn=AllWemoSetup_6_71.zip
$packageName    = 'allwemo'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\AllWemoSetup.msi" 
$checksum       = '1A923962B66B544EE7B602CB063BCE9F97C12C29C25FEF1424F2737AF855ED68'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /qn /norestart'
  softwareName   = 'AllWemo*'
  checksum       = $checksum
  checksumType   = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
Remove-Item $url
