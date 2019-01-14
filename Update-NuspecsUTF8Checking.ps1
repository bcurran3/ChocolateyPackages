$oldheader='<?xml version="1.0"?>'
$header='<?xml version="1.0" encoding="utf-8"?>'
$UTF8check='<!-- Do not remove this test for UTF-8: if “Ω” does not appear as greek uppercase omega letter enclosed in quotation marks, you should use an editor that supports UTF-8, not this one. -->'
$newheader=$header + $UTF8check

Get-ChildItem *.nuspec -recurse |
    Foreach-Object {
        $c = ($_ | Get-Content)
		if ($c.startswith($oldheader)){
#		if (($c -match $header) -and ($c -notmatch $UTF8check)) {
		Write-Host " * Updating $_" -ForeGround Cyan
        $c = $c -replace $oldheader,$newheader
        [IO.File]::WriteAllText($_.FullName, ($c -join "`r`n"))
		}
    }