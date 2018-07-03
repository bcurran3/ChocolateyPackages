#http://www.majorgeeks.com/mg/getmirror/win7codecs,1.html
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName    = 'advanced-codecs' 
$url            = "$toolsDir\ADVANCED_Codecs_v1025.exe"
$checksum       = '518C7C9E08799A5ED3A4FE48A6142D26D602AF6619B9FF760D3E3ECFD0DDA1B0'
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