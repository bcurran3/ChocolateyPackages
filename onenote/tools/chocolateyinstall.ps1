$packageName    = 'onenote'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.onenote.com/download/win32/x86/en-US' 
$checksum       = 'BD64ECAD11EF2B8B53DD909DF876597BC4E10A6DDCF6B3BDE8AA408A3EAAA80B'
$url64          = 'https://www.onenote.com/download/win32/x64/en-US'
$checksum64     = '123AC286F6B6008FF48A9971F5FBB63A6C2D54AFF6C294A30549B5BC9F1E94A2'
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

