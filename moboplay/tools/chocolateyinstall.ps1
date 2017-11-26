$ErrorActionPreference = 'Stop'
$packageName    = 'moboplay'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://download.moboplay.com/packages/MobileAssistant/moboplay/pcexe/officialsite/MoboPlay_3.0.6.339.exe' 
$checksum       = 'CE90D19536AD6A61EEAD43E8B21D12721C63F54075969F0E611F2A1BF54E1701'
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