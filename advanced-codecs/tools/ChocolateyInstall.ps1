#http://www.majorgeeks.com/mg/getmirror/win7codecs,1.html
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$global:packageMaintainer = 'BCURRAN3'
$packageName    = 'advanced-codecs' 
$url            = "$toolsDir\ADVANCED_Codecs_v1035.exe"
$checksum       = '5E93846A9F7E8636AE656D15332BF5D73CF77F325C0606F70FEFDD9067C65818'
$installerType  = 'EXE'
$silentArgs     = '/S /v/qn'
$validExitCodes = @(0, 3010, 1641)
$softwareName   = 'Shark007 ADVANCED Codecs*'
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "ACinstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyPackage @packageArgs  
Show-ToastMessage "Shark007 ADVANCED Codecs installed." "Version $env:packageVersion."

Start-Sleep -s 10
Start-CheckandStop "Settings32"  
Start-CheckandStop "Settings64"  
Remove-Item $url