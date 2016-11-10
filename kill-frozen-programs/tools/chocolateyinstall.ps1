$ErrorActionPreference = 'Stop'
$packageName= 'kill-frozen-programs'
$installerType = 'ZIP'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.tweaking.com/files/setups/Tweaking.com-Kill_Frozen_Programs.exe' 
$checksum   = 'C4E40D55DCF9ED4348DC798E9DAC2558709CE5DCDADA9BFF5CFD2F9CF4AC3279'
$IconName   = 'Kill Frozen Programs'
$EXEFile    = 'Kill_Frozen_Program.exe'


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$IconName.lnk" -targetPath "$ToolsDir\Tweaking.com - Kill Frozen Programs\$EXEFile"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$IconName.lnk" -targetPath "$ToolsDir\Tweaking.com - Kill Frozen Programs\$EXEFile"

  
