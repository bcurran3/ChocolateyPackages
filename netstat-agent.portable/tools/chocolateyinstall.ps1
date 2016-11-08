$ErrorActionPreference = 'Stop'

$packageName= 'netstat-agent.portable' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://netstatagent.com/files/netagent-portable.zip' 
$ExeFile    = 'NetAgent.exe'
$ShortcutName = 'NetStat Agent'


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'NetStat Agent*' 
  checksum      = '506E9EB995B7D0FD0E4C22759CFA88C0BD87655631D5E274D49EB83B2796111C'
  checksumType  = 'sha256'
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\netagent-portable\$ExeFile"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\netagent-portable\$ExeFile" -WorkingDirectory "$toolsDir"