$packageName    = 'setacl' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://helgeklein.com/downloads/SetACL/current/SetACL%20(executable%20version).zip'
$checksum       = '09E34E294C95BA7967C5463ECA1ACB571B745620CC2F58527DD1C1F154436EE0'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
