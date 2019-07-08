$ErrorActionPreference = 'Stop'
$packageName    = 'irfanviewplugins'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = Join-Path $toolsDir "iview453_setup.exe"
$url64          = Join-Path $toolsDir "iview453_x64_setup.exe"
					  
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  file           = $url
  file64         = $url64
  validExitCodes = @(0)
  silentArgs     = '/silent'
  softwareName   = ''
  checksum       = '7ebcf9fe4f4e41293d8808d2ad4b369577209dc64db04d79b1bce370e2c79b69'
  checksumType   = 'sha256'
  checksum64     = '57b12aed758d5beb84263cdca2d4fa38d0bcffa882d9994921453b170edf149a'
  checksumType64 = 'sha256'
}

Install-ChocolateyInstallPackage @packageArgs  

#Remove-Item $url | Out-Null
#Remove-Item $url64 | Out-Null
