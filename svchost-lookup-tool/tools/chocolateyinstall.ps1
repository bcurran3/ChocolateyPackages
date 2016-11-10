$ErrorActionPreference = 'Stop'
$packageName= 'svchost-lookup-tool'
$installerType = 'EXE'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.tweaking.com/files/setups/Tweaking.com-svchost.exe_Lookup_Tool.exe' 
$checksum   = '770218F6AD2D8F3E3B5A3DA591D096D9F100F4D3234C5816B9179AAEA327D5E1'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\svchost Lookup Tool.lnk" -targetPath "$ToolsDir\Tweaking.com - svchost.exe Lookup Tool\lookup_svchost.exe"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\svchost Lookup Tool.lnk" -targetPath "$ToolsDir\Tweaking.com - svchost.exe Lookup Tool\lookup_svchost.exe"
