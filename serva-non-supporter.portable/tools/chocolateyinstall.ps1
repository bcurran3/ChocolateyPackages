$ErrorActionPreference = 'Stop'
$packageName= 'serva-non-supporter.portable' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.vercot.com/~serva/download/Serva_Non-Supporter_32_v2.1.4.zip'
$url64      = 'http://www.vercot.com/~serva/download/Serva_Non-Supporter_64_v2.1.4.zip'
$processor = Get-WmiObject Win32_Processor

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  url64bit      = $url64 
}

Install-ChocolateyZipPackage @packageArgs

$is64bit = $processor.AddressWidth -eq 64
if ($is64bit) {
   Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Serva.lnk" -targetPath "$toolsDir\Serva64.exe" -WorkingDirectory "$toolsDir"
   Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Serva.lnk" -targetPath "$toolsDir\Serva64.exe" -WorkingDirectory "$toolsDir"
  } else {
   Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Serva.lnk" -targetPath "$toolsDir\Serva32.exe" -WorkingDirectory "$toolsDir"
   Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Serva.lnk" -targetPath "$toolsDir\Serva32.exe" -WorkingDirectory "$toolsDir"
  }