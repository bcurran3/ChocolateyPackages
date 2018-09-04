$ErrorActionPreference = 'Stop'
$packageName  = 'taskschedulerview' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortcutName = 'TaskSchedulerView.lnk'
$exe          = 'TaskSchedulerView.exe'
$url          = "$toolsDir\taskschedulerview.zip"
$checksum     = 'A2076933E4FCFD2CDD4558B3489DC681A0978900BAEBC84D262661422DFBA627'
$url64        = "$toolsDir\taskschedulerview-x64.zip"
$checksum64   = '148AFEC0565CF9C3BC14C16FC6B5EE9DBB2A7024A5171BD346455F9882ED846E'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs
Remove-Item "$toolsDir\*.zip" | out-null

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe"    
