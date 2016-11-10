$ErrorActionPreference = 'Stop'
$packageName= 'change-dns-servers'
$installerType = 'ZIP'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.tweaking.com/files/setups/Tweaking.com-Change_DNS_Servers.exe' 
$checksum   = '195683028AF6F8C01BB745453F631C0AD31CCE43F029B39A25CD38CB59C30B2F'
$IconName   = 'Change DNS Servers'
$EXEFile    = 'Change_DNS_Servers.exe'


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$IconName.lnk" -targetPath "$ToolsDir\Tweaking.com - Change DNS Servers\$EXEFile"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$IconName.lnk" -targetPath "$ToolsDir\Tweaking.com - Change DNS Servers\$EXEFile"

  
