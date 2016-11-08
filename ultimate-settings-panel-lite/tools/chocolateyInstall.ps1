$packageName  = 'ultimate-settings-panel-lite'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://downloads.sourceforge.net/project/ultimatesettingspanelpro/v4.2/UltimateSettingsPanel.zip'


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = 'A5BA9DAAB21F7A29804D29BD280AD2F41F78CB297BF3A792BC79EA710B363F91'
  checksumType  = 'sha256' 
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Ultimate Settings Panel.lnk" -targetPath "$env:ChocolateyInstall\lib\ultimate-settings-panel-lite\tools\UltimateSettingsPanel\UltimateSettingsPanel.exe"
