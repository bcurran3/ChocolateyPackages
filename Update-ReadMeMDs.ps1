$oldheader='https://raw.githubusercontent.com'
$newheader='https://cdn.staticaly.com/gh'

Get-ChildItem readme.md -recurse |
    Foreach-Object {
        $c = ($_ | Get-Content)
		if ($c -match $oldheader) {
		Write-Host " * Updating $_" -ForeGround Cyan
        $c = $c -replace $oldheader,$newheader
        [IO.File]::WriteAllText($_.FullName, ($c -join "`r`n"))
		}
    }