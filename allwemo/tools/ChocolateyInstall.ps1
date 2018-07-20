# https://ea.im/Doc.aspx?D=196&dn=AllWemo_setup_3_37.zip
$packageName    = 'allwemo'
$global:packageMaintainer = 'BCURRAN3'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\AllWemo.msi" 
$checksum       = 'BD69701574526395F2F3A285B77A6DEEF318ECF72F907C3D0F9FF27376B79F68'
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

Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyPackage @packageArgs
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."
Remove-Item $url
