$ErrorActionPreference = 'Stop'
$packageName  = 'data-lifeguard-diagnostic'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://downloads.wdc.com/windlg/WinDlg_v1_36.zip'
$checksum     = 'CC6ADB8DDCADD7ECEEC9BBCAADA4ACD1921164C272D13E1AFE02F8E43AFB779B'
$exeInstaller = "$toolsDir\WinDlg_v1_36.exe"
 
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
    file           = $exeInstaller
    fileType       = 'EXE'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    softwareName   = 'Data Lifeguard Diagnostic*'
    validExitCodes = @(0)   
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $exeInstaller | Out-Null
