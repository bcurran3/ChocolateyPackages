$ErrorActionPreference = 'Stop'
$packageName = 'siv' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits        = Get-ProcessorBits

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = "$toolsDir\siv_v$env:ChocolateyPackageVersion.zip"
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
Remove-Item "$toolsDir\*.zip" | Out-Null
Get-ChildItem -Path $toolsDir -Recurse | Where {
 $_.Extension -eq '.exe'} | % {
 New-Item $($_.FullName + '.ignore') -Force -ItemType file
} | Out-Null
