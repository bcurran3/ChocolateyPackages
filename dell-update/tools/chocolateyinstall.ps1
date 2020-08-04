$ErrorActionPreference = 'Stop'
$packageName = 'dell-update' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://dl.dell.com/FOLDER06240517M/1/Dell-Update-Application_CKWJ2_WIN_3.1.2_A00.EXE'
$checksum    = '2A4913ABE6A2BA36168B96BDFC636A15438F5D1E7B1665FB580A57D02D342BAD'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = '/s /l="c:\test\DUPlog.txt"'
  validExitCodes= @(0,2)
  softwareName  = 'Dell Update for Windows 10' 
}

Install-ChocolateyPackage @packageArgs
