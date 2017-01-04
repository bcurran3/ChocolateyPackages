#http://files2.majorgeeks.com/fc76150735dde1d2d860aeb77ee2009e/multimedia/ADVANCED_Codecs_v693.exe

$packageName   = 'advanced-codecs' 
$installerType = 'EXE'
$silentArgs    = '/S /v/qn'
$validExitCodes= @(0, 3010, 1641)
$softwareName  = 'Shark007 ADVANCED Codecs*'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = "$toolsDir\ADVANCED_Codecs_v693.exe"
$checksum      = '9790B72C40727BEA2B96630576762ED4A425AAF982B0583660EEA46B0071E25F'


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