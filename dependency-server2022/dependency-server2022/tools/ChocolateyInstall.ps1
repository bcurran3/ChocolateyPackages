$ErrorActionPreference = 'Stop'
$packageName    = 'dependency-server2022'

$IsWinServer=((Get-CimInstance Win32_OperatingSystem | Select-Object Caption) -match "Server")
if ($IsWinServer) {
  } else {
    Write-Warning "This package requires Windows Server 2022."
	throw
  }

# Build 20348.169 is the 2021/08/18 LTSC release of Server 2022
$IsCorrectBuild=[Environment]::OSVersion.Version.Build
if ($IsCorrectBuild -lt "20348")
   {
    Write-Warning "This package requires Windows Server 2022."
	throw
   }
