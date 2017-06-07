$packageName = 'font-awesome-font'
$url         = 'http://fontawesome.io/assets/font-awesome-4.7.0.zip'
$checksum    = '4E22A3FB2BB157269261FB7DB1444845192426874DB43E24087B4A4D2A7739D4'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destination = Join-Path $toolsDir 'font-awesome-4.7.0'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum 
  checksumType  = 'sha256'  
  }
  
Install-ChocolateyZIPPackage @packageArgs
 
$shell = New-Object -ComObject Shell.Application
$fontsFolder = $shell.Namespace(0x14)
 
Get-ChildItem $destination -Recurse -Filter *.otf |
ForEach-Object { $fontsFolder.CopyHere($_.FullName) }
Remove-Item $destination -Recurse

