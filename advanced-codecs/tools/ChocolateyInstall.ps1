#http://www.majorgeeks.com/mg/getmirror/win7codecs,1.html
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$global:packageMaintainer = 'BCURRAN3'
$packageName    = 'advanced-codecs' 
$url            = "$toolsDir\ADVANCED_Codecs_v1045.exe"
$checksum       = '1EC4417E4E9A65DB466F64EDF2E49DD2932C25E24C184C8674B950E55FC7B808'
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

Install-ChocolateyPackage @packageArgs  
Start-Sleep -s 10
Start-CheckandStop "Settings32"  
Start-CheckandStop "Settings64"  
Remove-Item $url