$packageName= 'dell-update' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://downloads.dell.com/FOLDER04566212M/1/Dell-Update-Application_HKMCJ_WIN_1.9.60.0_A00.EXE'
$checksum   = '0861FAFDCA7438D59D3B8CE00A419101BF58E376D34148F3D31396332A605904'

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
