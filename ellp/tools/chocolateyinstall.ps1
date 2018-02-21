$packageName    = 'ellp'
$installerType  = 'exe'
$url            = 'https://www.ellp.com/download/ellp/EllpSetup.exe'
$checksum       = '7A6926AF73A9ECAA8BC8201EC07BF5903007320C016BF8D206F479C2607875D5'
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
 
