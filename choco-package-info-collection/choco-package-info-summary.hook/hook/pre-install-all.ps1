$ErrorActionPreference = 'Continue'
# choco-package-info-summary.hook v1.0 (2023-07-01) Copyleft 2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Suggestions? Problems? Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues

function FormatStringWithIndentation {
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$InputString
    )

    $indentation = "     "
    $lineLength = 75

    # Replace all newline characters with a space
    $processedString = $InputString -replace "`r?`n", " "

    $outputString = ""

    while ($processedString.Length -gt 0) {
        if ($processedString.Length -le $lineLength) {
            # If remaining string is shorter than or equal to line length, add it as is
            $outputString += $indentation + $processedString.Trim()
            $processedString = ""
        } else {
            # Find the last space within the first lineLength characters
            $lastSpaceIndex = $processedString.Substring(0, $lineLength).LastIndexOf(" ")

            if ($lastSpaceIndex -ge 0) {
                # If a space is found, split the line at the space
                $outputString += $indentation + $processedString.Substring(0, $lastSpaceIndex).Trim() + "`n"
                $processedString = $processedString.Substring($lastSpaceIndex + 1).TrimStart()
            } else {
                # If no space is found, split the line at lineLength
                $outputString += $indentation + $processedString.Substring(0, $lineLength).Trim() + "`n"
                $processedString = $processedString.Substring($lineLength).TrimStart()
            }
        }
    }

    return $outputString
}

if (Test-Path "$env:chocolateyPackageFolder\$env:chocolateyPackageName.nuspec"){
    $nuspecXML = "$env:chocolateyPackageFolder\$env:chocolateyPackageName.nuspec"
    [xml]$nuspecFile = Get-Content $nuspecXML -TotalCount 750
	$NuspecTitle = $nuspecFile.package.metadata.title
    $NuspecSummary = $nuspecFile.package.metadata.summary
	if ($NuspecSummary){
		Write-Host "  ** $($NuspecTitle.toupper()) SUMMARY:" -Foreground Cyan
		Write-Host "$(FormatStringWithIndentation "$NuspecSummary")" -Foreground Cyan
	}
} else {
	Write-Host "$env:chocolateyPackageFolder\$env:chocolateyPackageName.nuspec not found." -Foreground Cyan
}
