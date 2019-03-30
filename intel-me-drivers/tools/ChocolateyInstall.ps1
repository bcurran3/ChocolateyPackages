$ErrorActionPreference = 'Stop'
$packageName   = 'intel-me-drivers' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$pp            = Get-PackageParameters
$unzipLocation = "$toolsDir\unzippedfiles"
$url           = 'https://downloadmirror.intel.com/28679/eng/ME_SW_1909.12.0.1236.zip'
$checksum      = 'AF42C06A6322BEACCD4B28FA80997B6679A12E6BB688E099C141369046ECB6EC'

New-Item $unzipLocation -Type Directory | Out-Null

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

#consumer version arguments (default)
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$unzipLocation\ME_SW_$ENV:ChocolateyPackageVersion\Cons\ME_SW_MSI\SetupME.exe"
  silentArgs     = '-overwrite -s -preinst'
  validExitCodes = @(0)
  softwareName   = 'Intel® Management Engine Components'
}

#corporate version arguments (specified only)
$packageArgs2 = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$unzipLocation\ME_SW_$ENV:ChocolateyPackageVersion\Cor\ME_SW_MSI\SetupME.exe"
  silentArgs     = '-overwrite -s -preinst'
  validExitCodes = @(0)
  softwareName   = 'Intel® Management Engine Components'
}

# select consumer (default) or corporate install version
if ($pp["TYPE"] -ne $null -or $pp["TYPE"] -ne '')
    {
     if ($pp["TYPE"] -eq "consumer")
         {
		  Write-Host "  ** Installing Consumer version of Intel Management Engine Components." -Foreground Magenta
          Install-ChocolateyInstallPackage @packageArgs
         }
	 if ($pp["TYPE"] -eq "corporate")
	     {
		  Write-Host "  ** Installing Corporate version of Intel Management Engine Components." -Foreground Magenta
	      Install-ChocolateyInstallPackage @packageArgs2
	     }
    }

if ($pp["TYPE"] -eq $null -or $pp["TYPE"] -eq '')
     { 
	   Write-Host "  ** Installing Consumer version of Intel Management Engine Components." -Foreground Magenta
	   Install-ChocolateyInstallPackage @packageArgs
     }
	
Start-Sleep -s 10
Remove-Item $unzipLocation -Recurse | Out-Null
