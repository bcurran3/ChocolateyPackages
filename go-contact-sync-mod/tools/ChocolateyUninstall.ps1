$ErrorActionPreference = 'Stop'; 

$packageName = 'go-contact-sync-mod'
$softwareName = 'GO Contact Sync Mod*' 
$installerType = 'MSI' 

$silentArgs = '/qn /norestart'
$validExitCodes = @(0, 3010, 1605, 1614, 1641)
$uninstalled = $false
try {
  Get-ItemProperty -Path @( 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
                            'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
                            'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' ) `
                   -ErrorAction:SilentlyContinue `
  | Where-Object   { $_.DisplayName -like "$softwareName*" } `
  | ForEach-Object { Uninstall-ChocolateyPackage -PackageName "$packageName" `
                                                 -FileType "$installerType" `
                                                 -SilentArgs "$($_.PSChildName) $silentArgs" `
                                                 -ValidExitCodes $validExitCodes }
} catch {
  throw $_.Exception
}