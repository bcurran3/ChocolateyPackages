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
    $checksum       = '711C3E19323E4BCEB845D6B3691FE2AC75AF7DCD15167ADAE7047E55D0B52D53'
} else {
	# Intel 11th Generation processors and earlier
	$url            = 'https://downloadmirror.intel.com/28539/Intel%20Processor%20Identification%20Utility-Legacy.exe'
    $checksum       = 'B406D7EAAA288B066127AA0EAC296654CED904E478ADBF8D2CE8CD62E97AFB7F'
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
