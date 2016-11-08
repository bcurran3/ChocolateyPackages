$ErrorActionPreference = 'Stop'
$packageName= 'unifying' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.logitech.com/pub/controldevices/unifying/unifying250.exe'
$silentArgs = '/S' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  checksum      = 'ACE27F43E1CE4925E72C49A33FCC2AA3B3DB557ED808F29E75DACEDFEBF7AB90'
  checksumType  = 'sha256'    
  silentArgs    = $silentArgs
  softwareName  = 'Logitech Unifying Software*' 
  }
  
Install-ChocolateyPackage @packageArgs

Start-Sleep -s 2
if((get-process "DJCUHost" -ea SilentlyContinue) -eq $Null){ 
        echo "DJCUHost not running... (Good!)" 
}
else{ 
    echo "Stopping DJCUHost post install..."
    Stop-Process -processname "DJCUHost"
 }
