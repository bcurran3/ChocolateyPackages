$packageName    = 'onenote'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.onenote.com/download/win32/x86/en-US' 
$checksum       = '4621396997A72B6A13C402390D35F32176B7951B876F73BED382BCD944FCC014'
$url64          = 'https://www.onenote.com/download/win32/x64/en-US'
$checksum64     = 'B7F5F676507ECDAFA4E54E6F790A18E074EB6A83A15011D6BF353326D89C24B3'
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

