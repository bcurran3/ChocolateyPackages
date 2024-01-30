$ErrorActionPreference = 'Stop'
$packageName   = 'data-lifeguard-diagnostic'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$TodaysVersion = ($env:ChocolateyPackageVersion -replace '[.]','_')
$url           = "http://downloads.wdc.com/windlg/WinDlg_v"+$TodaysVersion+".zip"
$checksum      = '931C8D9515F661B73DE8322A9C298403A90181F01DD6081C1B39F6F7B4E8CA4F'
 
$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256' 
}
  
Install-ChocolateyZipPackage @packageArgs 
 
$packageArgs = @{
    packageName    = $packageName
    file           = "$toolsDir\WinDlg_v"+$TodaysVersion+".exe"
    fileType       = 'EXE'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    softwareName   = 'Data Lifeguard Diagnostic*'
    validExitCodes = @(0)   
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -EA SilentlyContinue | Out-Null
