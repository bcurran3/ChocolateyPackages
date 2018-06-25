$ErrorActionPreference = 'Stop'
$packageName = 'desktopicons-winconfig'
$pp          = Get-PackageParameters

if ($pp["RenameComputer"] -eq "yes" -or $pp["RenameComputer"] -eq "YES" -or $pp["RenameComputer"] -eq "Yes")
     {
      Set-ItemProperty -LiteralPath HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\"{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Name "(Default)" -Value $env:computername -Force -ErrorAction SilentlyContinue
	 } else {
	   if ($pp["RenameComputer"] -eq 'no' -or $pp["RenameComputer"] -eq 'NO' -or $pp["RenameComputer"] -eq 'No')
	     {
	      Set-ItemProperty -LiteralPath HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\"{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Name "(Default)" -Value "This PC" -Force -ErrorAction SilentlyContinue
		 }
	 }

if ($pp["RenameComputer2"] -eq 'yes' -or $pp["RenameComputer2"] -eq 'YES' -or $pp["RenameComputer2"] -eq 'Yes')
     {
	  Set-ItemProperty -LiteralPath HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\"{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Name "(Default)" -Value "$env:computername ($env:username)" -Force -ErrorAction SilentlyContinue
	 } else {
	   if ($pp["RenameComputer2"] -eq 'no' -or $pp["RenameComputer2"] -eq 'NO' -or $pp["RenameComputer2"] -eq 'No')
	     {
	      Set-ItemProperty -LiteralPath HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\"{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Name "(Default)" -Value "This PC" -Force -ErrorAction SilentlyContinue
		 }
	 }

if ($pp["AllIcons"] -eq 'yes' -or $pp["AllIcons"] -eq 'YES' -or $pp["AllIcons"] -eq 'Yes')
     {
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 0 -Force -ErrorAction SilentlyContinue
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 0 -Force -ErrorAction SilentlyContinue	  
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Value 0 -Force -ErrorAction SilentlyContinue
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Value 0 -Force -ErrorAction SilentlyContinue	  
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" -Value 0 -Force -ErrorAction SilentlyContinue
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" -Value 0 -Force -ErrorAction SilentlyContinue	  
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Value 0 -Force -ErrorAction SilentlyContinue
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Value 0 -Force -ErrorAction SilentlyContinue	  
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Value 0 -Force -ErrorAction SilentlyContinue
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Value 0 -Force -ErrorAction SilentlyContinue	  
	  Stop-Process -ProcessName Explorer
	  exit
     } else {
	   if ($pp["AllIcons"] -eq 'no' -or $pp["AllIcons"] -eq 'NO' -or $pp["AllIcons"] -eq 'No')
	     {
    	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 1 -Force -ErrorAction SilentlyContinue
    	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 1 -Force -ErrorAction SilentlyContinue		  
	      Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Value 1 -Force -ErrorAction SilentlyContinue
	      Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Value 1 -Force -ErrorAction SilentlyContinue		  
	      Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" -Value 1 -Force -ErrorAction SilentlyContinue
	      Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" -Value 1 -Force -ErrorAction SilentlyContinue		  
	      Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Value 1 -Force -ErrorAction SilentlyContinue
	      Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Value 1 -Force -ErrorAction SilentlyContinue		  
	      Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Value 1 -Force -ErrorAction SilentlyContinue
	      Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Value 1 -Force -ErrorAction SilentlyContinue		  
		  Stop-Process -ProcessName Explorer
		  exit
	     }
	  }	
#This PC
if ($pp["Computer"] -eq 'yes' -or $pp["Computer"] -eq 'YES' -or $pp["Computer"] -eq 'Yes')
     {
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 0 -Force -ErrorAction SilentlyContinue
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 0 -Force -ErrorAction SilentlyContinue	  
     } else {
	   if ($pp["Computer"] -eq 'no' -or $pp["Computer"] -eq 'NO' -or $pp["Computer"] -eq 'No')
	     {
	      Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 1 -Force -ErrorAction SilentlyContinue
	      Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 1 -Force -ErrorAction SilentlyContinue		  
	     }
	  }
#My Documents	  
if ($pp["UserFiles"] -eq 'yes' -or $pp["UserFiles"] -eq 'YES' -or $pp["UserFiles"] -eq 'Yes')
     {
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Value 0 -Force -ErrorAction SilentlyContinue
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Value 0 -Force -ErrorAction SilentlyContinue	  
     } else {
	   if ($pp["UserFiles"] -eq 'no' -or $pp["UserFiles"] -eq 'NO' -or $pp["UserFiles"] -eq 'No')
	     {
	      Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Value 1 -Force -ErrorAction SilentlyContinue
	      Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Value 1 -Force -ErrorAction SilentlyContinue		  
	     }
	  }	  
#Control Panel	  
if ($pp["ControlPanel"] -eq 'yes' -or $pp["ControlPanel"] -eq 'YES' -or $pp["ControlPanel"] -eq 'Yes')
     {
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" -Value 0 -Force -ErrorAction SilentlyContinue
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" -Value 0 -Force -ErrorAction SilentlyContinue	  
     } else {
	   if ($pp["ControlPanel"] -eq 'no' -or $pp["ControlPanel"] -eq 'NO' -or $pp["ControlPanel"] -eq 'No')
	     {
	      Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" -Value 1 -Force -ErrorAction SilentlyContinue
	      Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" -Value 1 -Force -ErrorAction SilentlyContinue		  
	     }
	  }	 
#Network
if ($pp["Network"] -eq 'yes' -or $pp["Network"] -eq 'YES' -or $pp["Network"] -eq 'Yes')
     {
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Value 0 -Force -ErrorAction SilentlyContinue
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Value 0 -Force -ErrorAction SilentlyContinue	  
     } else {
	   if ($pp["Network"] -eq 'no' -or $pp["Network"] -eq 'NO' -or $pp["Network"] -eq 'No')
	     {
	      Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Value 1 -Force -ErrorAction SilentlyContinue
	      Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Value 1 -Force -ErrorAction SilentlyContinue		  
	     }
	  }	 	   
#Recycle Bin
if ($pp["RecycleBin"] -eq 'yes' -or $pp["RecycleBin"] -eq 'YES' -or $pp["RecycleBin"] -eq 'Yes')
     {
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Value 0 -Force -ErrorAction SilentlyContinue
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Value 0 -Force -ErrorAction SilentlyContinue	  
     } else {
	   if ($pp["RecycleBin"] -eq 'no' -or $pp["RecycleBin"] -eq 'NO' -or $pp["RecycleBin"] -eq 'No')
	     {
	      Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Value 1 -Force -ErrorAction SilentlyContinue
	      Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Value 1 -Force -ErrorAction SilentlyContinue		  
	     }
	  }		   
#OneDrive	  
if ($pp["OneDrive"] -eq 'yes' -or $pp["OneDrive"] -eq 'YES' -or $pp["OneDrive"] -eq 'Yes')
     {
	  Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Value 0 -Force -ErrorAction SilentlyContinue
     } else {
	   if ($pp["OneDrive"] -eq 'no' -or $pp["OneDrive"] -eq 'NO' -or $pp["OneDrive"] -eq 'No')
	     {
	      Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Value 1 -Force -ErrorAction SilentlyContinue
	     }
	  }	
	  
Stop-Process -ProcessName Explorer
