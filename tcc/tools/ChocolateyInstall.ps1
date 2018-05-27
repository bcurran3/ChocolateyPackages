$packageName = 'tcc'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileType    = 'exe'
$silentArgs  = '/quiet'
$url         = 'https://jpsoft.com/downloads/v22/tcc.exe'
$checksum    = 'F2CD29509D3BF8867D52DF0A016FC4BDB9DA7FD636AF7BA41A607BBF166FBD08'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $fileType 
  url           = $url
  silentArgs    = $silentArgs
  softwareName  = 'TCC 22' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
  
Install-ChocolateyPackage @packageArgs