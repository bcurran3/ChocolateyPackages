$ErrorActionPreference = 'Stop'
$packageName = 'dns-benchmark' 
$toolsDir    = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\DNS Benchmark.lnk" -targetPath "$toolsDir\DNSBench.exe"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\DNS Benchmark.lnk" -targetPath "$toolsDir\DNSBench.exe"
