$ErrorActionPreference = 'Stop'
$packageName= 'cobian-backup' 
$softwareName = 'Cobian Backup 11 Gravity*'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://files.cobiansoft.com/programz/cbSetup.exe'
$validExitCodes=@(0, 3010, 1641)

New-Item "$env:Temp\cobian-backup\" -Type Directory -force
New-Item "$env:Temp\cobian-backup\11.2.0.582" -Type Directory -force
copy-item -Path "$ToolsDir\cbsetup.txt" -destination "$env:Temp\cobian-backup\11.2.0.582\"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = ''
  softwareName  = $softwareName
  checksum      = '9EC08D76E4B810DE2C3CBC7BD90787CC462DEB0ACCC6996CAB2394AB261C7154'
  checksumType  = 'sha256'   
}

Install-ChocolateyPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Cobian Backup 11 - Application.lnk" -targetPath "C:\Program Files\Cobian Backup 11\Cobian.exe" -WorkingDirectory "C:\Program Files\Cobian Backup 11\"
      