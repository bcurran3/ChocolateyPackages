$packageName = 'siv' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = "$toolsDir\siv.zip"
$bits        = Get-ProcessorBits

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
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
