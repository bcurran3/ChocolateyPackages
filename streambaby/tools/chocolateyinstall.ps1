$packageName = 'streambaby'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://cytranet.dl.sourceforge.net/project/streambaby/streambaby-0.54.zip'
$checksum    = '934106829C63B1EBED70C80B15CFB66A2E9B145385060F706E818876168055C0'
$oldINI      = 'env:ChocolateyInstall\lib-bkp\streambaby.ini'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\streambaby.lnk" -targetPath "$toolsDir\streambaby-0.54\streambaby.bat" -iconLocation "$toolsDir\streambaby.ico"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\streambaby.lnk" -targetPath "$toolsDir\streambaby-0.54\streambaby.bat" -iconLocation "$toolsDir\streambaby.ico"

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null

If (Test-Path $oldINI)
    {
     Write-Host "Restoring previous streambaby.ini" -foreground "magenta" –backgroundcolor "blue"
     Copy-Item $oldINI "$toolsDir\streambaby-0.54\"
    }Else{
	 Write-Host "No previous streambaby.ini found." -foreground "magenta" –backgroundcolor "blue"
   }
