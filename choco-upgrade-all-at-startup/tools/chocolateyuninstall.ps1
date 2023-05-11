$ErrorActionPreference = 'Stop'
$packageName = 'choco-upgrade-all-startup'
$scriptDir   = "$(Get-ToolsLocation)\BCURRAN3"

SchTasks /Delete /TN “choco-upgrade-all-startup” /F

if (!(Test-Path "$ENV:ChocolateyInstall\lib\choco-upgrade-all-at")) {
    Remove-Item "$ENV:ChocolateyInstall\bin\choco-upgrade-all.bat" -Force -ErrorAction SilentlyContinue
    Remove-Item "$ENV:ChocolateyInstall\bin\choco-install.bat" -Force -ErrorAction SilentlyContinue
    Remove-Item "$scriptDir\choco-upgrade-all.*" -Force -ErrorAction SilentlyContinue | Out-Null
    $CTL=Get-ToolsLocation
    if (!(Get-ChildItem -Path "$CTL\BCURRAN3" | Measure-Object | %{$_.Count})) {
        $ENV:Path.Replace("$CTL\BCURRAN3","") | Out-Null
        Remove-Item "$CTL\BCURRAN3" | Out-Null
    }
}
