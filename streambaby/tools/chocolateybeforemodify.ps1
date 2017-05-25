$packageName = 'streambaby'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$currentINI  = '$toolsDir\streambaby-0.53\streambaby.ini'

If (Test-Path $currentINI)
    {
     Write-Host "Backing up current streambaby.ini" -foreground "magenta" –backgroundcolor "blue"
     Copy-Item $currentINI "$env:ChocolateyInstall\lib-bkp"
    }Else{
      Write-Host "No current streambaby.ini found." -foreground "magenta" –backgroundcolor "blue"
     }