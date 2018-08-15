$ErrorActionPreference = 'Stop';
$packageName = 'revo-uninstaller'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://www.revouninstaller.com/download-freeware-version.php'
$checksum    = '50501911770154E644E4ADA45C8E3522FE8064AF021CE0101AF95DAF43FCB57E'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  softwareName   = 'Revo Uninstaller*'
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-" 
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
