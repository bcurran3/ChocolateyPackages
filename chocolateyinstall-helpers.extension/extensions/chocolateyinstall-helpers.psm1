$scriptRoot = Split-Path -Path $MyInvocation.MyCommand.Definition
 
$publicFunctions = @(
    'Get-Is32.ps1',
    'Get-Is64.ps1',
    'Get-IsAMDVideo.ps1',
    'Get-IsInDomain.ps1',
    'Get-IsIntelVideo.ps1',
    'Get-IsNvidiaVideo.ps1',
    'Get-IsSSD.ps1',
    'Get-IsVirtualBox.ps1',
    'Get-IsVM.ps1',
    'Get-IsVMware.ps1',
    'Get-IsWin10.ps1',
    'Get-IsWin7.ps1',
    'Get-IsWin8.ps1',
    'Get-IsWin80.ps1',
    'Get-IsWin81.ps1',
    'Get-IsWinClient.ps1',
    'Get-IsWinEdu.ps1',
    'Get-IsWinEnt.ps1',
    'Get-IsWinHome.ps1',
    'Get-IsWinPro.ps1',
    'Get-IsWinServer.ps1',
    'Get-PendingReboot.ps1',
    'Get-WinName.ps1',
    'Get-WinVerBuild.ps1',
    'Get-WinVerMajor.ps1',
    'Get-WinVerMinor.ps1'
)
 
Get-ChildItem -Path "$scriptRoot\*.ps1" | ForEach-Object { . $_ }
Export-ModuleMember -Function $publicFunctions