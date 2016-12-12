#http://files1.majorgeeks.com/735dd629ab696e3a1bfcc0fe0d687bb1/multimedia/ADVANCED_Codecs_v682.exe

$packageName   = 'advanced-codecs' 
$installerType = 'EXE'
$silentArgs    = '/S /v/qn'
$validExitCodes= @(0, 3010, 1641)
$softwareName  = 'Shark007 ADVANCED Codecs*'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = "$toolsDir\ADVANCED_Codecs_v682.exe"
$checksum      = 'E052344A7398104A1AB55F8068A4768BB0415A71EFA056E2999C08BAE7A7F433'


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