$ErrorActionPreference = 'Stop'
$packageName = 'choco-nuspec-checker'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$script      = 'CNC.ps1'
$CNCHeader   = 'CNCHeader.txt'
$CNCFooter   = 'CNCFooter.txt'
$CheckExecutionPolicy = Get-ExecutionPolicy

Write-Host "  ** $packageName - FYI: Your PowerShell Execution Policy is currently set to $CheckExecutionPolicy" -ForeGround Yellow

Move-Item "$toolsDir\$script" $ENV:ChocolateyInstall\bin -Force 

if (!(Test-Path $ENV:ChocolateyInstall\bin\$CNCHeader)) {
    Move-Item "$toolsDir\$CNCHeader" $ENV:ChocolateyInstall\bin -Force
	$WhoAmI=whoami
    $Acl = Get-Acl "$ENV:ChocolateyInstall\bin\$CNCHeader"
    $Ar = New-Object  system.security.accesscontrol.filesystemaccessrule($WhoAmI,"FullControl","Allow")
    $Acl.SetAccessRule($Ar)
    Set-Acl "$ENV:ChocolateyInstall\bin\$CNCHeader" $Acl
   }
if (!(Test-Path $ENV:ChocolateyInstall\bin\$CNCFooter)) {
    Move-Item "$toolsDir\$CNCFooter" $ENV:ChocolateyInstall\bin -Force
	$WhoAmI=whoami
    $Acl = Get-Acl "$ENV:ChocolateyInstall\bin\$CNCFooter"
    $Ar = New-Object  system.security.accesscontrol.filesystemaccessrule($WhoAmI,"FullControl","Allow")
    $Acl.SetAccessRule($Ar)
    Set-Acl "$ENV:ChocolateyInstall\bin\$CNCFooter" $Acl	
   }
