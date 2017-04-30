$packageName  = 'spydetectfree' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.worktime.com/download/spydetectfree.zip'
$checksum     = '98C9B5079F7BBFF0A61D49D6EC821B64ED2EAC089A9FF251D2A412237C54BC17'
$url64        = 'http://www.worktime.com/download/spydetectfree64.zip'
$checksum64   = '53C2561223028EA3FF9C23AA6A82AE3A71A78DCCEBB46DFD5A431F06DD9F3E2E'
$shortcutName = 'SpyDetectFree.lnk'
$exe          = 'SpyDetectFree.exe'
$exe64        = 'SpyDetectFree64.exe'
$bits         = Get-ProcessorBits

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

if ($bits -eq 64)
   {
    Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe64" -WorkingDirectory "$toolsDir"
    Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe64"    
   } else {
    Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir"
    Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe"       
    }
