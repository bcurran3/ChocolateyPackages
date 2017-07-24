$packageName    = 'onenote'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.onenote.com/download/win32/x86/en-US' 
$checksum       = '564420FEF0E91050FB062CA1C2689BDCF06BA594E79421885BF64363A57253B3'
$url64          = 'https://www.onenote.com/download/win32/x64/en-US'
$checksum64     = '57DBCDF04C547AA18D15232E5C60B6CFC2774047E8CBD1D64F5C78936F852442'
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

