$packageName= 'google-play-music-manager' 
$softwareName  = 'Music Manager*'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://dl.google.com/tag/s/appguid%3D%7BEA25377A-280A-4539-8FED-21FACE57594F%7D%26iid%3D%7BE95DDA79-FC4B-89A8-2C65-B321BB685F88%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DMusic%2520Manager%26needsadmin%3Dfalse/androidjumper/win/musicmanagerinstaller.exe'
$validExitCodes= @(0)
$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $toolsDir "GPMMinstall.ahk"
$ahkProc = Start-Process -FilePath $ahkExe `
                         -ArgumentList $ahkFile `
                         -PassThru

$ahkId = $ahkProc.Id
Write-Debug "$ahkExe start time:`t$($ahkProc.StartTime.ToShortTimeString())"
Write-Debug "Process ID:`t$ahkId"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs   = '' 
  softwareName  = $softwareName
  checksum      = 'BAC313D41D97BD8A9A7AFCBAD0D16569CE7D37E120AA1CB5005895BDB6969B25'
  checksumType  = 'sha256'  
  validExitCodes= $validExitCodes
  }
  
Install-ChocolateyPackage @packageArgs

