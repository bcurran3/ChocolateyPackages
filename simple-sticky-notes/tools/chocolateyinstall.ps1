$packageName    = 'simple-sticky-notes'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www.simplestickynotes.com/setup/Setup_SimpleStickyNotes.exe'
$checksum       = '7141E617C89427425ED25BDAAE1BFB1F0DDA44652221A88B27C0C2FB0F07E30D'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir  
  fileType      = 'EXE'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'   
  validExitCodes= @(0,1)
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName  = 'Simple Sticky Notes*'
}

Install-ChocolateyPackage @packageArgs

