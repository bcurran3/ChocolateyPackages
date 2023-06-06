$ErrorActionPreference = 'Stop'
$packageName = 'dell-update' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://dl.dell.com/FOLDER10012597M/1/Dell-Update-Windows-Universal-Application_34YNX_WIN_4.9.0_A01.EXE?uid=922303f7-d1c7-46f6-d488-2a6114ea42bf&fn=Dell-Update-Windows-Universal-Application_34YNX_WIN_4.9.0_A01.EXE'
$checksum    = 'EB5578DAB065E0145EFCB232A145B7DA7E662F7165FCC2F61EDFCE1408CB8839'

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
