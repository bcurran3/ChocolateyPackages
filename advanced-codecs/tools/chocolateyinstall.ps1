#http://files2.majorgeeks.com/6157966f9b9e2f35d2266675bad8b7f8/multimedia/ADVANCED_Codecs_v703.exe

$packageName   = 'advanced-codecs' 
$installerType = 'EXE'
$silentArgs    = '/S /v/qn'
$validExitCodes= @(0, 3010, 1641)
$softwareName  = 'Shark007 ADVANCED Codecs*'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = "$toolsDir\ADVANCED_Codecs_v703.exe"
$checksum      = '897B3CA87B9A299CA486FAC948107BB77CF8BB6AB3044890FF90B9930B226361'


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