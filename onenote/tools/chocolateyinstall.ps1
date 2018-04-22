$packageName    = 'onenote'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.onenote.com/download/win32/x86/en-US' 
$checksum       = '641C19E3B78E73F5B9229AD416B8284D15EA26B15CCC0FD374E0B24C3412CFBB'
$url64          = 'https://www.onenote.com/download/win32/x64/en-US'
$checksum64     = 'A75E2D54A20F042C7D7A78593596CF9AD5001F1F4E94A71A946AE157ECEDB947'
$silentArgs     = ''
$validExitCodes = @(0)

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE' 
  url            = $url
  url64          = $url64
  softwareName   = 'Microsoft OneNote Home and Student 2016*' 
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'  
  silentArgs     = $silentArgs
  validExitCodes = $validExitCodes
}

Install-ChocolateyPackage @packageArgs 

if((get-process "OfficeC2RClient" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "OfficeC2RClient currently NOT running." 
  }else{ 
    Write-Host "Stopping OfficeC2RClient process..."
    Stop-Process -processname "OfficeC2RClient"
  }

