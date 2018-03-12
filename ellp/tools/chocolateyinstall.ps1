$packageName    = 'ellp'
$installerType  = 'exe'
$url            = 'https://www.ellp.com/download/ellp/EllpSetup.exe'
$checksum       = 'AF147B7C6AC4D698BD31B60A10ABF5142E7F97F690DA2CCAF45D8F8158F77167'
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
 
