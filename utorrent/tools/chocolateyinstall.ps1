$packageName    = 'utorrent'
$installerType  = 'exe'
$url            = 'http://download.ap.bittorrent.com/track/stable/endpoint/utorrent/os/windows'
$checksum       = '3C07BF16CA597238ED71FE37A56D76FD9860146D64EA0BF14AC68849681FE37E'
$silentArgs     = '/S'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0,1)
$softwareName   = 'uTorrent*'
$extractDir     = "$toolsDir\extracted"
$fileLocation   = "$extractDir\Carrier.exe"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $extractDir
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
  softwareName  = $softwareName
}
 
Install-ChocolateyInstallPackage @packageArgs

Start-Sleep -s 5

if((get-process "utorrent" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "uTorrent currently NOT running." 
  }else{ 
    Write-Host "Stopping uTorrent process(es)..."
    Stop-Process -processname utorrent* -force
  }

if((get-process "Carrier" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "uTorrent (Carrier) currently NOT running." 
  }else{ 
    Write-Host "Stopping uTorrent (Carrier) process(es)..."
    Stop-Process -processname Carrier -force
  }  

Remove-Item $extractDir -recurse | out-null  