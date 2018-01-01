$packageName  = 'spydetectfree' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.worktime.com/download/spydetectfree.zip'
$checksum     = 'B0F653B6907696605C4C61AAB51E1B35B163C518AD9F6AE69EACB25B12A13D73'
$url64        = 'http://www.worktime.com/download/spydetectfree64.zip'
$checksum64   = 'D350634F0C4789D91267715DD44C1F6BF723CFD77D20D34E9F48ED3A97186A3A'
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
