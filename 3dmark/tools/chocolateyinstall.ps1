$ErrorActionPreference = 'Stop'
$packageName= '3dmark' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://us1-dl.techpowerup.com/Benchmarking/Futuremark/3DMark-v2-1-2973.zip'
$silentArgs = '/S'
$validExitCodes= @(0)
$fileLocation = "$env:ChocolateyInstall\lib\3dmark\tools\3dmark-setup.exe"

choco --execution-timeout=7200

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = '8BF23AFBCD17F7B5BDD5FB5FC31F21EC0328D5BC136EAD6519F400849A9CEA33'
  checksumType  = 'sha256'
}

#Install-ChocolateyZipPackage @packageArgs 
Install-ChocolateyZipPackage @packageArgs --execution-timeout=7200

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = '3DMark*'
}
 
Install-ChocolateyInstallPackage @packageArgs --execution-timeout=7200

if((get-process "FMSISvc" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "Futuremark SystemInfo currently NOT running." 
  }else{ 
    Write-Host "Stopping Futuremark SystemInfo process..."
    Stop-Process -processname "FMSISvc" -Force
  }
