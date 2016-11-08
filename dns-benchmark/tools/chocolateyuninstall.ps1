$packageName= 'dns-benchmark' 

remove-item "$env:Public\Desktop\DNS Benchmark.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\DNS Benchmark" -Force -ErrorAction 'SilentlyContinue'