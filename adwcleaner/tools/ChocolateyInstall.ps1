$ErrorActionPreference = 'Stop'
$packageName       = 'adwcleaner' 
$toolsDir          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortcutName      = 'AdwCleaner.lnk'
$portableEXE       = "adwcleaner_$env:packageVersion.exe"
$urlBeforeDownload = 'https://download.toolslib.net/download/file/1/1735';
$regexDownloadLink = '^https://download.toolslib.net/download/file/';
$SourcePageBeforeDownload = Invoke-WebRequest -Uri $urlBeforeDownload -UseBasicParsing;
$htmlLink          = $SourcePageBeforeDownload.Links | Where-Object href -match $regexDownloadLink;
$url               = $htmlLink.href;
$checksum          = '55B7ACEB5ED0407B1D83CD07C448B65366576315A69D8842B9361B2A14240FC6'

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
Install-BinFile -Name adwcleaner -Path "$toolsDir\$portableEXE"

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$portableEXE" -WorkingDirectory "$toolsDir\"
