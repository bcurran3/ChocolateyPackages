#http://files1.majorgeeks.com/e1ff732f0ec0f1ce7338c8927cb7d77150ae79b4/multimedia/ADVANCED_Codecs_v828.exe
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName    = 'advanced-codecs' 
$url            = "$toolsDir\ADVANCED_Codecs_v828.exe"
$checksum       = '3AF12388E16525556150086B181764C38AF8912A716A5CF0DA460F91A448361F'
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

Start-Sleep -s 20

if((get-process "Settings32" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "Settings32 currently NOT running." 
  }else{ 
    Write-Host "Stopping Settings32 process..."
    Stop-Process -processname "Settings32" -force
  }
 
if((get-process "Settings64" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "Settings64 currently NOT running." 
  }else{ 
    Write-Host "Stopping Settings64 process..."
    Stop-Process -processname "Settings64" -force
  }

Remove-Item $url