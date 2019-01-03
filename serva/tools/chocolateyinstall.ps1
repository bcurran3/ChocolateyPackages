$ErrorActionPreference = 'Stop'
$packageName = 'serva' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://www.vercot.com/~serva/download/Serva_Community_32_64_v3.2.0.zip'
$checksum    = 'AC7C9EE0DD322A373C6CA4616435E4EA359A14C13FD069F16EEDD95073331B3A'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksumType  = 'sha256' 
}

Install-ChocolateyZipPackage @packageArgs

if (Get-ProcessorBits 64) {
   Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Serva.lnk" -targetPath "$toolsDir\Serva64.exe" -WorkingDirectory "$toolsDir"
   Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Serva.lnk" -targetPath "$toolsDir\Serva64.exe" -WorkingDirectory "$toolsDir"
  } else {
   Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Serva.lnk" -targetPath "$toolsDir\Serva32.exe" -WorkingDirectory "$toolsDir"
   Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Serva.lnk" -targetPath "$toolsDir\Serva32.exe" -WorkingDirectory "$toolsDir"
  }