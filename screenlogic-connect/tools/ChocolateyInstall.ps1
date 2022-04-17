$ErrorActionPreference = 'Stop'
$packageName    = 'screenlogic-connect'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.pentair.com/content/dam/extranet/nam/pentair-pool/residential/automation/screenlogic2/screenlogic-firmware/setup.exe'
$checksum       = '6DEABE14ACD64F1ECEEA6677AB0E8AABFE99C80B2A1717B3F3A2E9BE583A70DA'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir  
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0,1)
  silentArgs     = '/quiet'
  softwareName   = 'Pentair ScreenLogic'
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs

$packageArgs = @{
  packageName  = $packageName
  FileFullPath = "$toolsDir\pentairupdate.exe"
  url          = 'https://www.pentair.com/content/dam/extranet/nam/pentair-pool/residential/automation/screenlogic2/screenlogic-firmware/pentairupdate.exe'
  checksum     = 'BC3A19B1B01A0D0AEEDFDC85584EF77B6A8ED783E0D0BEFEB4F3291761AFA3BA'
  checksumType = 'sha256'
}

Write-Host "  ** Downloading Protocol Adapter firmware tool for manual installation." -Foreground Magenta
Get-ChocolateyWebFile @packageArgs

$packageArgs = @{
  packageName  = $packageName
  FileFullPath = "$toolsDir\compatibilityupdate.exe"
  url          = 'https://www.pentair.com/content/dam/extranet/nam/pentair-pool/residential/automation/screenlogic2/screenlogic-firmware/32.exe'
  url64        = 'https://www.pentair.com/content/dam/extranet/nam/pentair-pool/residential/automation/screenlogic2/screenlogic-firmware/64.exe'
  checksum     = '6C52453110D7619BF0C82B0E140B98DA37426A1491510506AAE535EA23B588CC'
  checksum64   = '6A8088009495C770097C53358785C9EC52F7DFA98E285BBD7E3ACE13ECF8FC4C'
  checksumType = 'sha256'
}

Write-Host "  ** Downloading Compatibility Update for Connecting to previous Versions for manual installation." -Foreground Magenta
Get-ChocolateyWebFile @packageArgs

Write-Host "  ** Protocol Adapter f/w and Compatibility Update can be found in C:\ProgramData\chocolatey\lib\screenlogic-connect\tools\" -Foreground Magenta

