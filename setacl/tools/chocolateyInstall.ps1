$packageName    = 'setacl' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://helgeklein.com/downloads/SetACL/current/SetACL%203.1.2%20(executable%20version).zip'
$checksum       = 'BA74399A70963C156580180455FBFC0FA68EA673A64EB89010A46273C7D478CC'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
