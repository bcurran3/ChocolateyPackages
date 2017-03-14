$PassedParameter = $env:chocolateyPackageParameters

if ($PassedParameter) {
    $RunTime = $PassedParameter
	} else {
	  Write-Host "No time specified, defaulting to midnight."
	  $RunTime         = '00:00'
	  }

Write-Host "Now configured to run choco upgrade all at $Runtime every day."
SchTasks /Create /SC DAILY /RU SYSTEM /RL HIGHEST /TN "choco upgrade all at" /TR "el choco upgrade all" /ST $RunTime
