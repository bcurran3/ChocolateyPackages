$packageName = 'font-awesome-font'
$global:packageMaintainer = 'BCURRAN3'
$url         = 'https://use.fontawesome.com/releases/v5.1.1/fontawesome-free-5.1.1-desktop.zip'
$checksum    = '87808972A3CD7FA7EAEF7169DEA2ACA40EC4DCBFF599B1D3B2116A02EF69F739'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destination = Join-Path $toolsDir 'fontawesome-free-5.1.1-desktop'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum 
  checksumType  = 'sha256'  
  }
  
Show-Patreon "https://www.patreon.com/bcurran3"  
Install-ChocolateyZIPPackage @packageArgs
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."
 
$shell = New-Object -ComObject Shell.Application
$fontsFolder = $shell.Namespace(0x14)
 
Get-ChildItem $destination -Recurse -Filter *.otf |
ForEach-Object { $fontsFolder.CopyHere($_.FullName) }
Remove-Item $destination -Recurse

