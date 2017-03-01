#http://files2.majorgeeks.com/37f65c068b7723cd7809ee2d31d7861c/multimedia/ADVANCED_Codecs_v722.exe

$packageName   = 'advanced-codecs' 
$installerType = 'EXE'
$silentArgs    = '/S /v/qn'
$validExitCodes= @(0, 3010, 1641)
$softwareName  = 'Shark007 ADVANCED Codecs*'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = "$toolsDir\ADVANCED_Codecs_v722.exe"
$checksum      = 'FB0ED173803C4E73619DDF93CF9FA88E2B20FA7FA9AE455AA6FD2E0B2B506375'

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