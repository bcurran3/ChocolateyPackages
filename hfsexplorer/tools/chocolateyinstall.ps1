$packageName= 'hfsexplorer'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://downloads.sourceforge.net/project/catacombae/HFSExplorer/0.23.1/hfsexplorer-0.23.1-setup.exe' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = 'EE7AFAC9E0C2D1A31035FAB8F175CE07F95FE6EDD29D19532DD09BB1E353F4F8'
  checksumType  = 'sha256'   
  silentArgs    = '/S'  
  validExitCodes= @(0) 
  softwareName  = 'HFSExplorer*'
}

Install-ChocolateyPackage @packageArgs
