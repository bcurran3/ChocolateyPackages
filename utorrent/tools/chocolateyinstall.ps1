$packageName = 'utorrent'
$installerType = 'exe'
$url        = 'http://download.ap.bittorrent.com/track/stable/endpoint/utorrent/os/windows/uTorrent.exe'
$silentArgs = '/S'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0,1)
$softwareName = 'uTorrent*'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir  
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = 'E1557810ADB59597366D167EFCD85A09D0AE2827F49EF6B8E6A459E56D6E1292'
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs

Start-Sleep -s 5

if((get-process "utorrent" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "uTorrent currently NOT running." 
  }else{ 
    Write-Host "Stopping uTorrent process(es)..."
    Stop-Process -processname utorrent* -force
  }
