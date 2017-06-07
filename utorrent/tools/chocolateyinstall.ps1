$packageName    = 'utorrent'
$installerType  = 'exe'
$url            = 'http://download.ap.bittorrent.com/track/stable/endpoint/utorrent/os/windows'
$checksum       = '154442D57D5F785C73A20EFC3F83CE95C87DE46AD057EB8F386C6A451028C34E'
$silentArgs     = '/S'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0,1)
$softwareName   = 'uTorrent*'

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

Start-Sleep -s 5

if((get-process "utorrent" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "uTorrent currently NOT running." 
  }else{ 
    Write-Host "Stopping uTorrent process(es)..."
    Stop-Process -processname utorrent* -force
  }
