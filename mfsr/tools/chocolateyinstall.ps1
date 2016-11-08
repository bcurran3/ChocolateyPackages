$packageName= 'mfsr' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.rosswalker.co.uk/tivo_upgrade/mfsr.exe'
$installerPackage = Join-Path $toolsDir "mfsr.exe"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  fileFullPath  = $installerPackage
  url           = $url
  checksum      = 'B69B6E26C9FECB18D694F46B16A92FE60A541FD74308C5EA9D63A40505FDAFE9'
  checksumType  = 'sha256'
}

#Get-ChocolateyWebFile $packageName $installerPackage $url 
Get-ChocolateyWebFile @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$packageName.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\mfsr.exe"
