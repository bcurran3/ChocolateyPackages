$packageName   = 'angryip'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = "$toolsDir\ipscan-$env:ChocolateyPackageVersion-setup.exe"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $url
  silentArgs    = '/S'
  softwareName  = 'Angry IP Scanner*' 
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -force | Out-Null
Remove-Item $toolsDir\*.ignore -force | Out-Null
