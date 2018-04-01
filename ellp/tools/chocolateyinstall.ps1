$packageName    = 'ellp'
$installerType  = 'exe'
$url            = 'https://www.ellp.com/download/ellp/EllpSetup.exe'
$checksum       = 'BBCDF2C4C032B666DD8E41BD0B2BCE871257E5B9265BBE37E14AE81B89145A95'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0,1)
$softwareName   = 'Ellp*'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir  
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs

Start-Sleep -s 10

if((get-process "ellp" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "Ellp currently NOT running." 
  }else{ 
    Write-Host "Stopping Ellp process..."
    Stop-Process -processname "ellp" -force
  }
 
