$packageName    = 'ultimate-settings-panel'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.sourceforge.net/project/ultimatesettingspanelpro/v5.8/UltimateSettingsPanel.zip'
$checksum       = 'FA0A1C329F072B7B18A4D0F43A8B89A1E9C702E7DE767BB371ABE56D3B3FA4D6'
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

Remove-Item $toolsDir\x64 -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item $toolsDir\x86 -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item $toolsDir\*.url -Force -ErrorAction SilentlyContinue

