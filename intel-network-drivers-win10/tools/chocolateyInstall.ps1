$ErrorActionPreference = 'Stop'
$packageName    = 'intel-network-drivers-win10' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzippedfiles"
$bits           = Get-ProcessorBits
$url            = 'https://downloadmirror.intel.com/25016/eng/PROWin32.exe'
$checksum       = '362099EA0289ACD3F6849F962CA374641BBF7E7E24F7321623C886FAFBB509DF'
$url64          = 'https://downloadmirror.intel.com/25016/eng/PROWinx64.exe'
$checksum64     = 'DDAAF1E4D3031C231D8A60D716FD24EAC5D43A05FD431A3539A3156B1C6188AF'


if (Get-IsIntelVideo)
  {
   Write-Host "  ** Intel network adapter found." -Foreground Magenta
  } else {
   Write-Host "No Intel network adapters found. Aborting." -Foreground Red
   throw
   }

New-Item $unzipLocation -Type Directory | Out-Null

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64    
  checksum64     = $checksum64  
  checksumType64 = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

if ($bits -eq 64)
   {
	$url = "$unzipLocation\APPS\PROSETDX\Winx64\DxSetup.exe"
   } else {
	$url = "$unzipLocation\APPS\PROSETDX\Win32\DxSetup.exe"
   }

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $url
  silentArgs     = '/qn'
  validExitCodes = @(0)
  softwareName   = 'Intel(R) Network Connections*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Start-Sleep -s 10

Remove-Item $unzipLocation -Recurse | Out-Null
#Start-CheckandStop "AutoHotkey" - future use?
