$packageName  = 'blockjsvbs-winconfig'

cmd.exe /c assoc .js=txtfile
cmd.exe /c assoc .jse=txtfile
cmd.exe /c assoc .vbs=txtfile
cmd.exe /c assoc .vbe=textfile
Write-Host .js, .jse, .vbs, and .vbs script files will now open in your text editor instead of executing. -foreground magenta