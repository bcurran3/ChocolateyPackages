#http://www.majorgeeks.com/mg/getmirror/win7codecs,1.html
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName    = 'advanced-codecs' 
$url            = "$toolsDir\ADVANCED_Codecs_v1032.exe"
$checksum       = '612A0C57B186AD2DA2762DCD210DB76DA2C6C4B0A03A5B275FAD3CE7B3A15F4F'
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