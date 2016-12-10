#http://files2.majorgeeks.com/cb11a12474e34b83e38e06d2ef1b2830/multimedia/ADVANCED_Codecs_v681.exe

$packageName   = 'advanced-codecs' 
$installerType = 'EXE'
$silentArgs    = '/S /v/qn'
$validExitCodes= @(0, 3010, 1641)
$softwareName  = 'Shark007 ADVANCED Codecs*'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = "$toolsDir\ADVANCED_Codecs_v681.exe"
$checksum      = '8E69FEC98C039FCE38584645E3094FA3B30037F79A09E599CCD665ED928AD2AC'


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