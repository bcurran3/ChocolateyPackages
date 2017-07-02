$packageName= 'dell-update' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://downloads.dell.com/FOLDER04317777M/1/Dell-Update-Application_31YHC_WIN_1.9.20.0_A00.EXE'
$checksum   = '6B386752BBA4DCF77301CDD2EF6D2EAEB7C7F1BC9619776201BF74F34DE10503'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = '/S' 
  softwareName  = 'Dell Update*' 
}

Install-ChocolateyPackage @packageArgs
