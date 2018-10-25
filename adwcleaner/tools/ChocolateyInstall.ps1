$ErrorActionPreference = 'Stop'
$packageName  = 'adwcleaner' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://toolslib.net/downloads/finish/1-adwcleaner/'
$checksum     = '55B7ACEB5ED0407B1D83CD07C448B65366576315A69D8842B9361B2A14240FC6'
$shortcutName = 'AdwCleaner.lnk'
$portableEXE  = ".exe"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = "$toolsDir\$portableEXE"
  softwareName  = ''
  checksum      = $checksum
  checksumType  = 'sha256'
}
 
Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"