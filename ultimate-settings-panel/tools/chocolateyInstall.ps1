$packageName    = 'ultimate-settings-panel'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$osBits         = Get-ProcessorBits
$url            = 'https://downloads.sourceforge.net/project/ultimatesettingspanelpro/v6.3/USPv63.zip'
$checksum       = '7962042F8CDDE61737CEF0DDAF40F6069628BD2F8B46FFDCCFCBE88A62919AD1'
$UnzippedEXE    = "$toolsDir\USPv63\Installers\Ultimate Settings Panel.msi"

if ($osBits -eq 32){
    Write-Warning "This program only supports 64 bit OSes. Aborting..."
    throw
   }

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
  fileType       = 'MSI'
  file           = $UnzippedEXE
  silentArgs     = '/quiet /qn /norestart'
  validExitCodes = @(0)
  softwareName   = 'Ultimate Settings Panel*'   
}

Install-ChocolateyInstallPackage @packageArgs	

Remove-Item $toolsDir\USPv63 -Recurse -Force -ErrorAction SilentlyContinue | out-null
