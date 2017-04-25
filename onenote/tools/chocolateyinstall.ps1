$packageName    = 'onenote'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://c2rsetup.officeapps.live.com/c2r/download.aspx?productReleaseID=OneNoteFreeRetail&platform=x86&language=en-US&version=O16GA&Source=O16ONF' 
$checksum       = '04DA8A36108F736597727B8DABF0290D8164E654ED2F5DD18F92FED0A3E282DA'
$url64          = 'https://c2rsetup.officeapps.live.com/c2r/download.aspx?productReleaseID=OneNoteFreeRetail&platform=x86&language=en-US&version=O16GA&Source=O16ONF'
$checksum64     = '699DA27776D2C586A6FA2FE045D07FC2FD81A66A9EFCD8C98082EBD576BE33B8'
$silentArgs     = ''
$validExitCodes = @(0)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "OneNoteInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  softwareName  = 'Microsoft OneNote Hom and Student 2016*' 
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Install-ChocolateyPackage @packageArgs 
