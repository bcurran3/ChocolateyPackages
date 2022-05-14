$ErrorActionPreference = 'Stop'
$packageName = 'streambaby'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloads.sourceforge.net/project/streambaby/streambaby-0.54.zip'
$checksum    = '934106829C63B1EBED70C80B15CFB66A2E9B145385060F706E818876168055C0'

if (Test-Path "$ENV:ChocolateyInstall\lib-bkp\streambaby\tools\streambaby-0.54\streambaby.ini")
    {
     Write-Host "  ** Backuping up previous v0.54 streambaby.ini." -Foreground Magenta
	 Copy-Item "$ENV:ChocolateyInstall\lib-bkp\streambaby\tools\streambaby-0.54\streambaby.ini" "$ENV:Temp" -Force
    }

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\streambaby.lnk" -targetPath "$toolsDir\streambaby-0.54\streambaby.bat" -iconLocation "$toolsDir\streambaby.ico"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\streambaby.lnk" -targetPath "$toolsDir\streambaby-0.54\streambaby.bat" -iconLocation "$toolsDir\streambaby.ico"

if (Test-Path "$ENV:Temp\streambaby.ini")
    {
     Write-Host "  ** Restoring previous v0.54 streambaby.ini." -Foreground Magenta
	 Rename-Item "$toolsDir\streambaby-0.54\streambaby.ini" "streambaby.ini.default"
     Move-Item "$ENV:Temp\streambaby.ini" "$toolsDir\streambaby-0.54\"
    }
   
$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | Out-Null
Get-ChildItem -Path $toolsDir -Recurse | Where {
 $_.Extension -eq '.exe'} | % {
 New-Item $($_.FullName + '.ignore') -Force -ItemType file
} | Out-Null

