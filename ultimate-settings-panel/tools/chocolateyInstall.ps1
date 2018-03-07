$packageName    = 'ultimate-settings-panel'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.sourceforge.net/project/ultimatesettingspanelpro/v5.9/USPv59.zip'
$checksum       = 'A456EB04F9CC48DA0EA4FF1D4C6378FAB999CC47F4C2EBE3A5D98C9D1EF138E2'
$silentArgs     = '/quiet /qn /norestart'
$validExitCodes = @(0)
$osBits         = Get-ProcessorBits

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyZipPackage @packageArgs

  if ($osBits -eq 64) 
    {
     $UnzippedEXE  = Join-Path $toolsDir 'USPv59\x64\Ultimate Settings Panel x64.msi'
    }
  else
    {
     $UnzippedEXE  = Join-Path $toolsDir 'USPv59\x86\Ultimate Settings Panel.msi'
    }

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  file          = $UnzippedEXE
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'Ultimate Settings Panel*'   
}

Install-ChocolateyInstallPackage @packageArgs	

Remove-Item $toolsDir\USPv59 -Force -Recurse -ErrorAction SilentlyContinue


