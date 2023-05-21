$ErrorActionPreference = 'Stop'
$packageName   = 'intel-processor-identification-utility'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$TodaysVersion = $env:ChocolateyPackageVersion

function Check-IntelProcessorGeneration {
    $processor = (Get-WmiObject Win32_Processor).Name
    if ($processor -match "12th") {
        return 12
    }
    elseif ($processor -match "13th") {
        return 13
    }
    elseif ($processor -match "14th") {
        return 14
    }
    elseif ($processor -match "15th") {
        return 15
    }
    else {
        return 0
    }
}

if (Check-IntelProcessorGeneration) {
	# Intel 12th Generation processors and later
	$url            = "https://downloadmirror.intel.com/28539/Intel%20Processor%20Identification%20Utility%20v"+$TodaysVersion+".exe"
    $checksum       = '30E2B8B7333A6598F7B3F60E93A41FDF6021D58B86FD8951280AD84CC138DF3A'
} else {
	# Intel 11th Generation processors and earlier
	$url            = 'https://downloadmirror.intel.com/28539/Intel%20Processor%20Identification%20Utility-Legacy.exe'
    $checksum       = '1916BAABF0E2530C997BFB82449D0F1F14E6D036FBE86494A027A2AC553D7E9C'
	Write-Host "  **  Installing Intel Processor Identification Utility LEGACY v6.10.28.0323" -Foreground Magenta
}



$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /norestart'
  softwareName   = 'Intel(R) Processor Identification Utility'
  checksum       = $checksum
  checksumType   = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  

# UPDATE INSTRUCTIONS:
# Update checksum(s)
# Update Write-Host LEGACY version statement if changed.
