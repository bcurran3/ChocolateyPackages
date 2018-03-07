$packageName    = 'ultimate-settings-panel'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.sourceforge.net/project/ultimatesettingspanelpro/v6.1/USPv61.zip'
$checksum       = '691FBAC73EE9F9CDE177C04C89D5FDC42F492900AB40AD7CE6FA6DF77FE41CC4'
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
     $UnzippedEXE  = Join-Path $toolsDir 'x64\Ultimate Settings Panel x64.msi'
    }
  else
    {
     $UnzippedEXE  = Join-Path $toolsDir 'x86\Ultimate Settings Panel x86.msi'
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


