$ErrorActionPreference = 'Stop'
$packageName = 'dell-update' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloads.dell.com/FOLDER10791749M/1/Dell-Update-Windows-Universal-Application_534C4_WIN_5.1.0_A00.EXE'
$checksum    = '7AD11A0AD05215397F1F431256CBEF36241C685AE8A37B2CAFB17C51BD097712'

Confirm-Win10

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = '/s'
  validExitCodes= @(0,2)
  softwareName  = 'Dell Update' 
}

Install-ChocolateyPackage @packageArgs
Write-Warning "Note: Your system requires a restart after installing the application. The restart can be deferred but must be completed to ensure that the update is installed."

# UPDATE INSTRUCTIONS:
# You'll have to search for the URL as it always changes. Update the checksum.
