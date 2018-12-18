$packageName    = 'irfanviewplugins'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\iview452_plugins_setup.exe"
$url64          = "$toolsDir\iview452_plugins_x64_setup.exe"
					  
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $url
  file64         = $url64
  validExitCodes = @(0)
  silentArgs     = '/silent'
  softwareName   = ''
}

Install-ChocolateyInstallPackage @packageArgs  

Remove-Item $url | out-null
Remove-Item $url64 | out-null