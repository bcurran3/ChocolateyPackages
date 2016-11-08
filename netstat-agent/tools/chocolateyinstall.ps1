$ErrorActionPreference = 'Stop'

$packageName= 'netstat-agent' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://netstatagent.com/files/netagent-setup.exe' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'NetStat Agent*' 
  checksum      = '85DD56241F89FB26C40FAB4DA2C1A22997D8A93F5FCBF6F4E11EC9D01C693C17'
  checksumType  = 'sha256'
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
