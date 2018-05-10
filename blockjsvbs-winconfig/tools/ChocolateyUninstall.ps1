$packageName = 'blockjsvbs-winconfig'

cmd.exe /c assoc .js=JSFile
cmd.exe /c assoc .jse=JSEFile
cmd.exe /c assoc .vbs=VBSFile
cmd.exe /c assoc .vbe=VBEFile
Write-Host .js, .jse, .vbs, and .vbs script files now re-associated back to default script engines. -foreground magenta