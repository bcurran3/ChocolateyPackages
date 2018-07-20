$packageName    = 'dokany-redistributable'
$global:packageMaintainer = 'BCURRAN3'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/dokan-dev/dokany/releases/download/v1.1.0.2000/DokanSetup_redist.exe'
$checksum       = '22B6A1E1BDAFCD8E7E105436B151D84374558FB2B868957AB0404998FF5EF4CD'
$silentArgs     = '/install /passive /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Dokan Library*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyPackage @packageArgs  
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."
  
