$ErrorActionPreference = 'Stop'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName = 'intel-processor-identification-utility'
$TodaysVersion = $env:ChocolateyPackageVersion
#$url         = "https://downloadmirror.intel.com/28539/Intel%20Processor%20Identification%20Utility%20v"+$TodaysVersion+".exe"
$url         = 'https://downloadmirror.intel.com/28539/Intel%20Processor%20Identification%20Utility%20v7.0.4.exe'
$checksum    = '711C3E19323E4BCEB845D6B3691FE2AC75AF7DCD15167ADAE7047E55D0B52D53'

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

if (!(Check-IntelProcessorGeneration)) {
	# Intel 11th Generation processors and earlier
	Write-Host "  **  intel-processor-identification-utility is for 12th Gen and newer processors." -Foreground Yellow
	Write-Host "  **  Use intel-processor-identification-utility-legacy for 11th Gen and older processors."  -Foreground Yellow
	throw
}


$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /norestart'
  softwareName   = 'Intel® Processor Identification Utility'
  checksum       = $checksum
  checksumType   = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  

# UPDATE INSTRUCTIONS:
# Update checksum(s)

