$packageName   = 'ultimate-settings-panel'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://downloads.sourceforge.net/project/ultimatesettingspanelpro/v5.6/UltimateSettingsPanel.zip'
$checksum      = 'C067CE8F98363A0A8D0315F83D6404CE37B17AECD01E939C3D400D2FB4194E75'
$silentArgs    = '/quiet /qn /norestart'
$validExitCodes= @(0)
$osBits        = Get-ProcessorBits

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
    $UnzippedEXE  = Join-Path $toolsDir 'x64\Ultimate Settings Panel.msi'
    }
  else
    {
    $UnzippedEXE  = Join-Path $toolsDir 'x86\Ultimate Settings Panel.msi'
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

