$packageName    = 'intel-dsa'
$installerType  = 'exe'
$url            = 'https://downloadmirror.intel.com/24345/a08/Intel%20Driver%20and%20Support%20Assistant%20Installer.exe'
$checksum       = '3EED30FFF567C995140A0DABDACF8960C4B7E9BCDA7F956B6479BFB60A903397'
$toolsDir       = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$silentArgs     = '/S'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'Intel® Driver Update Utility*'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs

Start-Sleep -s 20

if((get-process "SurConsent" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "SurConsent currently NOT running." 
  }else{ 
    Write-Host "Stopping SurConsent process..."
    Stop-Process -processname "SurConsent" -force
  }