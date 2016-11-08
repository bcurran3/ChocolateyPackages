$packageName= 'gptgen' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://heanet.dl.sourceforge.net/project/gptgen/gptgen/v1.1/gptgen-1.1.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = '8C1781F3F8B26D4C5BF6D1F0583B4417E91F2FBEDF8F480D7546B9EE2759A9FE'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
