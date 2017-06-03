$packageName  = 'erpxe' 
$url          = 'https://iweb.dl.sourceforge.net/project/erpxe/erpxe-1.2.tar.gz'
$checksum     = '6FD98501C8353D20DA0CDFFCADD2C56DD705276DCEEED8D4066E08462DA102CB'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$tftpd32dir   = "$env:ChocolateyInstall\lib\tftpd32\tools\"
$shortcutName = 'tftpd.lnk'
$exe          = 'tftpd32.exe'
$exe64        = 'tftpd64.exe'
$bits         = Get-ProcessorBits

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  FileFullPath   = "$toolsDir\erpxe-1.2.tar"
  Destination    = $toolsDir
  SpecificFolder = ""
}

Get-ChocolateyUnzip @packageArgs

remove-item "$toolsDir\erpxe-1.2.tar" -Force -ErrorAction 'SilentlyContinue'
   
$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null
icacls.exe $tftpd32dir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null

if ($bits -eq 64)
   {
    Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$tftpd32dir\$exe64" -WorkingDirectory "$tftpd32dir"
    Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$tftpd32dir\$exe64"   
   } else {
    Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$tftpd32dir\$exe" -WorkingDirectory "$tftpd32dir"
    Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$tftpd32dir\$exe"
   }
