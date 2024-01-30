$ErrorActionPreference = 'Stop'
$packageName = 'dns-benchmark' 
$toolsDir    = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\DNS Benchmark.lnk" -targetPath "$toolsDir\DNSBench.exe"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\DNS Benchmark.lnk" -targetPath "$toolsDir\DNSBench.exe"
Get-ChildItem -Path $toolsDir -Recurse | Where {
 $_.Extension -eq '.exe'} | % {
 New-Item $($_.FullName + '.ignore') -Force -ItemType file
} | Out-Null

