$packageName = 'font-awesome-font'
$global:packageMaintainer = 'BCURRAN3'
$url         = 'https://use.fontawesome.com/releases/v5.1.1/fontawesome-free-5.1.1-desktop.zip'
$checksum    = '87808972A3CD7FA7EAEF7169DEA2ACA40EC4DCBFF599B1D3B2116A02EF69F739'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destination = "$toolsDir\fontawesome-free-5.1.1-desktop"
$fontDir     = "$destination\otfs"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum 
  checksumType  = 'sha256'  
  }
  
Install-ChocolateyZIPPackage @packageArgs
 
Install-ChocolateyFont "$fontDir\Font Awesome 5 Brands-Regular-400.otf"
Install-ChocolateyFont "$fontDir\Font Awesome 5 Free-Regular-400.otf"
Install-ChocolateyFont "$fontDir\Font Awesome 5 Free-Solid-900.otf"
 
Remove-Item $destination -Recurse
