$ErrorActionPreference = 'Stop'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName = 'intel-processor-identification-utility-legacy'
$url         = 'https://downloadmirror.intel.com/28539/Intel%20Processor%20Identification%20Utility-Legacy.exe'
$checksum    = '2FB8269AC1977F45112191758D3A4DEB5E53B913F4C891D124630688954F9836'

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
	Write-Host "  **  intel-processor-identification-utility-legacy is for 11th Gen and older processors."  -Foreground Yellow
	Write-Host "  **  Use intel-processor-identification-utility for 12th Gen and newer processors." -Foreground Yellow
	throw
} 

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /norestart'
  softwareName   = 'Intel® Processor Identification Utility - Legacy'
  checksum       = $checksum
  checksumType   = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  

# UPDATE INSTRUCTIONS:
# Update checksum(s)
