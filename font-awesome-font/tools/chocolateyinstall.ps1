$packageName = 'font-awesome-font'
$url         = 'http://fontawesome.io/assets/font-awesome-4.7.0.zip'
$checksum    = '8DD560347F1850AE2BB9AE13AE33FDBB44B7AF00427FA15A4ED55A1A08AF30BB'
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

