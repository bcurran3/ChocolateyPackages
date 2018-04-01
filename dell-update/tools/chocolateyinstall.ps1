$packageName= 'dell-update' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://downloads.dell.com/FOLDER04792274M/1/Dell-Update-Application_P0KKN_WIN_1.11.1.0_A00.EXE'
$checksum   = '209919261607280C89C2F8B2970076C54C319E80379A3A096749355FFAA84454'

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
