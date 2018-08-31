# chocolatey-misc-helpers.extension v0.0.2 (07-19-2018) by Bill Curran - public domain
# Show-ToastMessage.ps1 - Sends a Windows toast message.
# Uses BurntToast (https://github.com/Windos/BurntToast) if installed. NOTE: v0.5.0+ no longer works on Windows 8.
# Otherwise uses the code I blatantly stole from https://gist.github.com/Windos/9aa6a684ac583e0d38a8fa68196bc2dc
# Example of use: Show-ToastMessage "$packageName installed." "Version $env:packageVersion."
# Not guaranteed to work on Windows versions other than Windows 10 and Server 2016. 
# Should do nothing on other versions; i.e. tested on Windows Server 2012 R2 - no messages, no errors.

# Below shows toast messages if the Chocolatey user has installed the PowerShell module BurntToast. 
# By installing BurntToast, Chocolatey users show a preference towards wanting toast messages and thus have opted-in for use of them.
function Show-ToastMessage($MessageLine1, $MessageLine2){

if (!(Test-Path "$ChocolateyInstall\extensions\chocolatey-misc-helpers\choco.ico")){
     [System.Reflection.Assembly]::LoadWithPartialName('System.Drawing')  | Out-Null
     [System.Drawing.Icon]::ExtractAssociatedIcon("$env:ChocolateyInstall\choco.exe").ToBitmap().Save("$env:ChocolateyInstall\extensions\chocolatey-misc-helpers\choco.ico")
}

if (Get-Module -ListAvailable -Name BurntToast -ErrorAction SilentlyContinue){
     New-BurntToastNotification -Text "Chocolatey ($env:packageName)", "$MessageLine1", "$MessageLine2" -AppLogo "$env:ChocolateyInstall\extensions\chocolatey-misc-helpers\choco.ico"
   } else {
     return
	}
# 08-30-2018
# The remainder of this function has been disallowed by the Chocolatey team as "pop ups" need to be 100% opt-in. :(
# Its purpose was to show toast messages to Windows10/Server2016 users who don't have BurntToast installed.

#     $app = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
#     [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
#     $Template = [Windows.UI.Notifications.ToastTemplateType]::ToastImageAndText01
#     #Gets the Template XML so we can manipulate the values
#     [xml]$ToastTemplate = ([Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent($Template).GetXml())
#     [xml]$ToastTemplate = @"
#<toast launch="app-defined-string">
#  <visual>
#    <binding template="ToastGeneric">
#      <text>Chocolatey ($env:packageName)</text>	
#      <text>$MessageLine1</text>
#      <text>$MessageLine2</text>
#	  <branding>logo</branding>
#	  <image placement="appLogoOverride" src="$env:ChocolateyInstall\extensions\chocolatey-misc-helpers\choco.ico"/>
#    </binding>
#  </visual>
#</toast>
#"@
#     $ToastXml = New-Object -TypeName Windows.Data.Xml.Dom.XmlDocument
#     $ToastXml.LoadXml($ToastTemplate.OuterXml)
#     $notify = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($app) 
#     $notify.Show($ToastXml)
#    }
}
