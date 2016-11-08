$packageName  = 'ultimate-settings-panel'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://heanet.dl.sourceforge.net/project/ultimatesettingspanelpro/v5.1/UltimateSettingsPanelv51.zip'
$silentArgs    = '/quiet /qn /norestart'
$validExitCodes= @(0)
$osBits = Get-ProcessorBits

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = '584B66AA593317337F97F26CB88C81A5997FBE1E34E134552BFF64C6E290E34F'
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

