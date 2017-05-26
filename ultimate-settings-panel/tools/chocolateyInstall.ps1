$packageName    = 'ultimate-settings-panel'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.sourceforge.net/project/ultimatesettingspanelpro/v5.7/UltimateSettingsPanel.zip'
$checksum       = '5C1B5A98C40E1A73306799E09B8B0BD55CF1B2242ACB45717E2A4F7364DA8C0C'
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
    $UnzippedEXE  = Join-Path $toolsDir 'Installers\x64\Ultimate Settings Panel x64.msi'
    }
  else
    {
    $UnzippedEXE  = Join-Path $toolsDir 'Installers\x86\Ultimate Settings Panel.msi'
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

