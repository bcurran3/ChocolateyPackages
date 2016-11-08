$ErrorActionPreference = 'Stop'
$packageName= 'serva' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://vercot.com/~serva/download/Serva_Community_32_v3.0.0.zip'
$url64      = 'http://vercot.com/~serva/download/Serva_Community_64_v3.0.0.zip'


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  url64bit      = $url64 
  checksum      = 'E953FE63D89EE27076656C5667F7F698AC2726B75836CA9008A07A98B4B1B03B'
  checksumType  = 'sha256' 
  checksum64    = '70DFDA58579CA5BA7B67AE1437C190AF40A5CB2936F52D1610BE15CB41F295DE'
  checksumType64= 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

if (Get-ProcessorBits 64) {
   Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Serva.lnk" -targetPath "$toolsDir\Serva64.exe" -WorkingDirectory "$toolsDir"
   Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Serva.lnk" -targetPath "$toolsDir\Serva64.exe" -WorkingDirectory "$toolsDir"
  } else {
   Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Serva.lnk" -targetPath "$toolsDir\Serva32.exe" -WorkingDirectory "$toolsDir"
   Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Serva.lnk" -targetPath "$toolsDir\Serva32.exe" -WorkingDirectory "$toolsDir"
  }