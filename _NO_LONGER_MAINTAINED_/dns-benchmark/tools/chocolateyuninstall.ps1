$ErrorActionPreference = 'Stop'
$packageName= 'dns-benchmark' 

Remove-Item "$ENV:Public\Desktop\DNS Benchmark.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\DNS Benchmark" -Force -ErrorAction SilentlyContinue
