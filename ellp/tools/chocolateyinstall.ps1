$packageName    = 'ellp'
$installerType  = 'exe'
$url            = 'https://download.ellp.com/download/ellp/EllpSetup.exe'
$checksum       = '67AD52323A1DB286B2197F6A748A0382D1BD71E1682530AF21E178108A06C3BC'
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
 
