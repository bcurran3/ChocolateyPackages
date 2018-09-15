$packageName   = 'intel-me-drivers' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$pp            = Get-PackageParameters
$unzipLocation = "$toolsDir\unzippedfiles"
$url           = 'https://downloadmirror.intel.com/28083/eng/ME_SW_1824.12.0.1140.zip'
$checksum      = 'A12196D391491F02EE13CCE100C7B4692ECBE09B985C0A6F83C9FBE2DE6D9F26'

New-Item $unzipLocation -type directory | out-null

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
  file           = "$unzipLocation\ME_SW_1824.12.0.1140\Consumer\ME_SW_MSI\SetupME.exe"
  silentArgs     = '-overwrite -s -preinst'
  validExitCodes = @(0)
  softwareName   = 'Intel® Management Engine Components'
}

#corporate version arguments (specified only)
$packageArgs2 = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$unzipLocation\ME_SW_1824.12.0.1140\Corporate\ME_SW_MSI\SetupME.exe"
  silentArgs     = '-overwrite -s -preinst'
  validExitCodes = @(0)
  softwareName   = 'Intel® Management Engine Components'
}

# select consumer (default) or corporate install version
if ($pp["TYPE"] -ne $null -or $pp["TYPE"] -ne '')
    {
     if ($pp["TYPE"] -eq "consumer")
         {
		  Write-Host "  ** Installing Consumer version of Intel Management Engine Components." -foreground magenta
          Install-ChocolateyInstallPackage @packageArgs
         }
	 if ($pp["TYPE"] -eq "corporate")
	     {
		  Write-Host "  ** Installing Corporate version of Intel Management Engine Components." -foreground magenta
	      Install-ChocolateyInstallPackage @packageArgs2
	     }
    }

if ($pp["TYPE"] -eq $null -or $pp["TYPE"] -eq '')
     { 
	   Write-Host "  ** Installing Consumer version of Intel Management Engine Components." -foreground magenta	  
	   Install-ChocolateyInstallPackage @packageArgs
     }
	
Start-Sleep -s 10
Remove-Item $unzipLocation -recurse | out-null
