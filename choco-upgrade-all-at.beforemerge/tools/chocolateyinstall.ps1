#https://github.com/chocolatey/choco/wiki/How-To-Parse-PackageParameters-Argument
$arguments = @{}
$packageParameters = $env:chocolateyPackageParameters
$Time = "00:00"

  if ($packageParameters) {
      $match_pattern = "\/(?<option>([a-zA-Z]+)):(?<value>([`"'])?([a-zA-Z0-9- _\\:\.]+)([`"'])?)|\/(?<option>([a-zA-Z]+))"
      $time = 'time'

      if ($packageParameters -match $match_pattern ){
          $results = $packageParameters | Select-String $match_pattern -AllMatches
          $results.matches | % {
            $arguments.Add(
                $_.Groups[$option_name].Value.Trim(),
                $_.Groups[$value_name].Value.Trim())
        }
      }
      else
      {
          Throw "Package Parameters were found but were invalid (REGEX Failure)"
      }

      if ($arguments.ContainsKey("Time")) {
          Write-Host "Time Argument Found"
          $port = $arguments["Time"]
      }

  } else {
      Write-Debug "No Package Parameters Passed in"
  }

#  $silentArgs = "/S /Port:" + $port + " /Edition:" + $edition + " /InstallationPath:" + $installationPath
#   if ($additionalTools) { $silentArgs += " /Additionaltools" }

  Write-Host "This would be the Chocolatey Silent Arguments: $silentArgs"


exit



$pp = Get-PackageParameters

if ($pp["Time"] -eq $null -or $pp["Time"] -eq '') { $pp["Time"] = '00:00' }

Write-Host Debug
Write-Host $pp
Write-Host Debug

if ($pp) {
    $Time = $pp
	} else {
	  Write-Host "No time specified, defaulting to midnight." -ForegroundColor red -BackgroundColor blue
	  $RunTime = '00:00'
	  }

Write-Host "Now configured to run choco upgrade all at $Runtime every day." -ForegroundColor green -BackgroundColor blue
SchTasks /Create /SC DAILY /TN "choco upgrade all at" /TR "el choco upgrade all" /ST $RunTime


#REF: https://github.com/chocolatey/choco/wiki/How-To-Parse-PackageParameters-Argument