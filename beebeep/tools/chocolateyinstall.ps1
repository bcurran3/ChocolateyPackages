$ErrorActionPreference = 'Stop'
$packageName= 'beebeep' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://pilotfiber.dl.sourceforge.net/project/beebeep/Windows/beebeep-3.0.7.zip'
#alt http://heanet.dl.sourceforge.net/project/beebeep/Windows/beebeep-3.0.7.zip
$ShortcutName = 'beeBEEP'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'zip' 
  url           = $url
  checksum      = '0E7B1B9E05CA90761B4EC53C62AFE4397D5E802910B5CFDF39B1E6F6ABDD108C'
  checksumType  = 'sha256'  
  }

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$toolsDir\beebeep-3.0.7\beeBEEP.exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\beebeep-3.0.7\beeBEEP.exe" -WorkingDirectory "$toolsDir"
