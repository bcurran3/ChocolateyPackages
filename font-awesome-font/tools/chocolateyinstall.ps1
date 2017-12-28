$packageName = 'font-awesome-font'
$url         = 'https://use.fontawesome.com/releases/v5.0.2/fontawesome-free-5.0.2.zip'
$checksum    = '77C18E313E2259639444126A676C5628DE61C822485F152F6610C382AB6F76ED'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destination = Join-Path $toolsDir 'fontawesome-free-5.0.2'

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

