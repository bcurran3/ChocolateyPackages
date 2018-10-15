$packageName = 'siv' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = "$toolsDir\siv.zip"
$checksum    = '9C9BA4BE3E6C4376BF32E8E0724B31459480983E6C8671F44C022DB13FB89894'
$bits        = Get-ProcessorBits

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  }
Install-ChocolateyZipPackage @packageArgs

if ($bits -eq 64)
   {
    Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\SIV.lnk" -targetPath "$toolsDir\SIV64X.exe" -WorkingDirectory "$toolsDir"
    Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\SIV.lnk" -targetPath "$toolsDir\SIV64X.exe"    
   } else {
    Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\SIV.lnk" -targetPath "$toolsDir\SIV32X.exe" -WorkingDirectory "$toolsDir"
    Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\SIV.lnk" -targetPath "$toolsDir\SIV32X.exe"       
   }
Remove-Item $url | out-null