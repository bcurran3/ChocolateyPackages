$ErrorActionPreference = 'Stop'
$packageName    = 'pcmark8' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://d1ejs5fxm96rib.cloudfront.net/PCM8/PCMark8-v2-7-613.zip'
$checksum       = 'EB834A88CA27FA26EE13813CF93E7FB8DAE6FD791F89C9E56B2B514AC563AEF4'
$silentArgs     = '/S'
$validExitCodes = @(0)
$fileLocation   = "$env:ChocolateyInstall\lib\pcmark8\tools\PCMark8-setup.exe"

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
  softwareName  = 'PCMark*'
}
 
Install-ChocolateyInstallPackage @packageArgs

if((get-process "FMSISvc" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "Futuremark SystemInfo currently NOT running." 
  }else{ 
    Write-Host "Stopping Futuremark SystemInfo process..."
    Stop-Process -processname "FMSISvc"
  }
