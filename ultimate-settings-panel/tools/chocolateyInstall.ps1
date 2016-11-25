$packageName   = 'ultimate-settings-panel'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'http://pilotfiber.dl.sourceforge.net/project/ultimatesettingspanelpro/v5.2/UltimateSettingsPanelv52.zip'
$checksum      = 'F19A96A134BD8883100B7E3C33D2F8FFDB2EB2798F86BB825DF546945038F1B5'
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
    $UnzippedEXE  = Join-Path $toolsDir 'Installers\x64\Ultimate Settings Panel x64.msi'
    }
  else
    {
    $UnzippedEXE  = Join-Path $toolsDir 'Installers\x86\Ultimate Settings Panel x86.msi'
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

