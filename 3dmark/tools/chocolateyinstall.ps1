$ErrorActionPreference = 'Stop'
$packageName    = '3dmark' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://akamai-dl.futuremark.com.akamaized.net/3DMark-v2-3-3732.zip'
$checksum       = '1D7B1F61A44EE141036A94FA88E0F513EB5F1F53F438AA8FEEAA933CFE016909'
$silentArgs     = '/S'
$validExitCodes = @(0)
$fileLocation   = "$toolsDir\3dmark-setup.exe"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = '3DMark*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item "$toolsDir\*.exe" | out-null
Remove-Item "$toolsDir\*.dlc" | out-null
Remove-Item "$toolsDir\*.msi" | out-null
Remove-Item "$toolsDir\redist" -recurse | out-null

if((get-process "FMSISvc" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "Futuremark SystemInfo currently NOT running." 
  }else{ 
    Write-Host "Stopping Futuremark SystemInfo process..."
    Stop-Process -processname "FMSISvc" -Force
  }
