$ErrorActionPreference = 'Stop';

$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    url            = 'https://download01.logi.com/web/ftp/pub/techsupport/options/Options_6.70.1197.exe'
    checkum        = '63FD5F943BBD338DB8F4868E0BDE2CE97742E46C23BB35F9FF83A6544272719C'
    checksumType   = 'sha256'
    fileType       = 'EXE'
    silentArgs     = ''
    validExitCodes = @(0)   
}

$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path -Path $env:TEMP -ChildPath "$(Get-Random).ahk" 
$ahkSourceFile = Join-Path -Path $toolsDir -ChildPath "$($env:ChocolateyPackageName)_install.ahk"
Copy-Item -Path $ahkSourceFile -Destination $ahkFile

Write-Verbose "Running AutoHotkey install script $ahkFile"
$ahkProc = Start-Process -FilePath $ahkExe -ArgumentList $ahkFile -PassThru
$ahkId = $ahkProc.Id
Write-Debug "$ahkExe start time:`t$($ahkProc.StartTime.ToShortTimeString())"
Write-Debug "Process ID:`t$ahkId"

Install-ChocolateyPackage @packageArgs

Start-Sleep -s 5

if((get-process "LogiOptionsUI" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "LogiOptionsUI currently NOT running." 
  }else{ 
    Write-Host "Stopping LogiOptionsUI process..."
    Stop-Process -processname "LogiOptionsUI" -force
  }
 