$arguments = @{}
$packageParameters = Get-PackageParameters

 if ($packageParameters) {
      $match_pattern = "\/(?<option>([a-zA-Z]+)):(?<value>([`"'])?([a-zA-Z0-9- _\\:\.]+)([`"'])?)|\/(?<option>([a-zA-Z]+))"
      $option_name = 'option'
      $value_name = 'value'

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
          Write-Host "Time argument found."
          $RunTime = $arguments["Time"]
      }
  } else {
      Write-Debug "No Package Parameters Passed"
  }
  

#if ($PassedParameter["Time"] -eq $null -or $PassedParameter["Time"] -eq '') 
#  { 
#    $PassedParameter["Time"] = '00:00' 
#	}
	
Write-Host pp is $packageParameters["Time"]
Write-Host runtime is $RunTime
Write-Host arguments time $arguments["Time"]
Write-Host time is $Time


if ($packageParameters) {
    $RunTime = $($packageParameters["Time"])
	} else {
	  Write-Host "No time specified, defaulting to midnight."
	  $RunTime         = '00:00'
	  }

Write-Host "Now configured to run choco upgrade all at '$RunTime' every day."
SchTasks /Create /SC DAILY /RU SYSTEM /RL HIGHEST /TN "choco upgrade all at" /TR "choco upgrade all --confirm" /ST $RunTime /F