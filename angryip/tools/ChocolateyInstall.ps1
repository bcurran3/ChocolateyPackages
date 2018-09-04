$packageName   = 'angryip'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = "$toolsDir\ipscan-3.5.3-setup.exe"
$checksum      = 'AC1E2D8DE30AE0048CFE3AE27FBDDCF3E16E38DCB33D9B83C16F32831C865219'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  silentArgs    = '/S'
  softwareName  = 'Angry IP Scanner*' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs
Remove-Item "$toolsDir\ipscan*.exe" | out-null