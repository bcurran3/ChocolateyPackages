$packageName    = 'onenote'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.onenote.com/download/win32/x86/en-US' 
$checksum       = '72FE85F3148A49214A5B0052BF59F3B1447F50ED77EA149F9E46171C23A433AA'
$url64          = 'https://www.onenote.com/download/win32/x64/en-US'
$checksum64     = 'C4C2C3A0D43620165187C8834B1FC33CFEAAC794514836C67EAC1BF111294A36'
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

