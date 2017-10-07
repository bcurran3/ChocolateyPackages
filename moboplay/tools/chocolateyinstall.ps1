$ErrorActionPreference = 'Stop'
$packageName    = 'moboplay'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://download.moboplay.com/packages/MobileAssistant/moboplay/pcexe/officialsite/MoboPlay_3.0.3.319.exe' 
$checksum       = '76B4FDC91B523766B25AD614A4A6DD62404A49E9E87B5619A29D3CEE839CF73D'
$silentArgs     = '/SILENT'
$validExitCodes = @(0,1)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'MoboPlay*'
  checksum      = $checksum 
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
Start-Sleep -s 10
  
if((get-process "iMoboPlay" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "MoboPlay for iOS not running. (Good!)" -foreground magenta
  }else{ 
    Write-Host "Stopping MoboPlay for iOS..." -foreground magenta
    Stop-Process -processname "iMoboPlay"
	}
	
if((get-process "aMoboPlay" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "MoboPlay for Android not running. (Good!)" -foreground magenta
  }else{ 
    Write-Host "Stopping MoboPlay for Android..." -foreground magenta
    Stop-Process -processname "aMoboPlay"
	}	