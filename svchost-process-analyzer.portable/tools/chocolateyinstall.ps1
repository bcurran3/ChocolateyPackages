$ErrorActionPreference = 'Stop'
$packageName= 'svchost-process-analyzer.portable'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.neuber.com/download/SvchostAnalyzer.exe'
$scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$ExeFile = 'SvchostAnalyzer.exe'
$ShortcutName = 'Svchost Process Analyzer'
$installerPackage = Join-Path $scriptDir $ExeFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = $installerPackage
  softwareName  = ''
  checksum      = '12D2146672A281319DEA9F2AD3D31C16FC5EB25479CCA271A986442214B7D7EB'
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\$ExeFile"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir"














