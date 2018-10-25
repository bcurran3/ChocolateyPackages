$ErrorActionPreference = 'Stop'
$packageName       = 'adwcleaner' 
$toolsDir          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortcutName      = 'AdwCleaner.lnk'
$portableEXE       = "adwcleaner_$env:packageVersion.exe"
$urlBeforeDownload = 'https://toolslib.net/downloads/finish/1-adwcleaner/1388/';
$regexDownloadLink = '^https://download.toolslib.net/download/file/';
$SourcePageBeforeDownload = Invoke-WebRequest -Uri $urlBeforeDownload -UseBasicParsing;
$htmlLink          = $SourcePageBeforeDownload.Links | Where-Object href -match $regexDownloadLink;
$url               = $htmlLink.href;
$checksum          = 'C9CFB0A07961616D5C4779E8A187D2EAB91D4310166C07F5063F1DC13D9FF5BA'

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