$ErrorActionPreference = 'Stop'
$packageName = 'taskbar-winconfig'
$pp          = Get-PackageParameters

# Taskbar icon size - Windows 7+
if ($pp["SIZE"] -ne $null -or $pp["SIZE"] -ne '')
     {
      if ($pp["SIZE"] -eq "big" -or $pp["SIZE"] -eq "BIG" -or $pp["SIZE"] -eq "Big")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSmallIcons" -Value 0 -ea SilentlyContinue
          }
	  if ($pp["SIZE"] -eq 'small' -or $pp["SIZE"] -eq 'SMALL' -or $pp["SIZE"] -eq 'Small')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSmallIcons" -Value 1 -ea SilentlyContinue
		  }
}

# Taskbar location - Windows 7+ - thanks Matt Wrock!
if ($pp["LOCATION"] -ne $null -or $pp["LOCATION"] -ne '')
     {
	   if ($pp["LOCATION"] -eq 'bottom' -or $pp["LOCATION"] -eq 'BOTTOM' -or $pp["LOCATION"] -eq 'Bottom')
	     {
	      Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" -Name Settings -Value ([byte[]] (0x28,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0x02,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x3e,0x00,0x00,0x00,0x2e,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x82,0x04,0x00,0x00,0x80,0x07,0x00,0x00,0xb0,0x04,0x00,0x00)) -ea SilentlyContinue
		 }
	   if ($pp["LOCATION"] -eq 'top' -or $pp["LOCATION"] -eq 'TOP' -or $pp["LOCATION"] -eq 'Top')
	     {
	      Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" -Name Settings -Value ([byte[]] (0x28,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0x02,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x3e,0x00,0x00,0x00,0x2e,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x80,0x07,0x00,0x00,0x2e,0x00,0x00,0x00)) -ea SilentlyContinue
		 }
	   if ($pp["LOCATION"] -eq 'left' -or $pp["LOCATION"] -eq 'LEFT' -or $pp["LOCATION"] -eq 'Left')
	     {
	      Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" -Name Settings -Value ([byte[]] (0x28,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0x02,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x3e,0x00,0x00,0x00,0x2e,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x3e,0x00,0x00,0x00,0xb0,0x04,0x00,0x00)) -ea SilentlyContinue
		 }
	   if ($pp["LOCATION"] -eq 'right' -or $pp["LOCATION"] -eq 'RIGHT' -or $pp["LOCATION"] -eq 'Right')
	     {
	      Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" -Name Settings -Value ([byte[]] (0x28,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0x02,0x00,0x00,0x00,0x02,0x00,0x00,0x00,0x3e,0x00,0x00,0x00,0x2e,0x00,0x00,0x00,0x42,0x07,0x00,0x00,0x00,0x00,0x00,0x00,0x80,0x07,0x00,0x00,0xb0,0x04,0x00,0x00)) -ea SilentlyContinue
		 }		 
	 }

# Taskbar lock - Windows 7+
if ($pp["LOCKED"] -ne $null -or $pp["LOCKED"] -ne '')
     {
      if ($pp["LOCKED"] -eq "yes" -or $pp["LOCKED"] -eq "YES" -or $pp["LOCKED"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSizeMove" -Value 0 -ea SilentlyContinue
          } 
      if ($pp["LOCKED"] -eq 'no' -or $pp["LOCKED"] -eq 'NO' -or $pp["LOCKED"] -eq 'No')
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSizeMove" -Value 1 -ea SilentlyContinue
      	  }
}

# Combine icons - Windows 7+
if ($pp["COMBINED"] -ne $null -or $pp["COMBINED"] -ne '')
     {
      if ($pp["COMBINED"] -eq "yes" -or $pp["COMBINED"] -eq "YES" -or $pp["COMBINED"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarGlomLevel" -Value 0 -ea SilentlyContinue
          } 
      if ($pp["COMBINED"] -eq 'full' -or $pp["COMBINED"] -eq 'FULL' -or $pp["COMBINED"] -eq 'Full')
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarGlomLevel" -Value 1 -ea SilentlyContinue
          }
      if ($pp["COMBINED"] -eq 'no' -or $pp["COMBINED"] -eq 'NO' -or $pp["COMBINED"] -eq 'No')
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarGlomLevel" -Value 2 -ea SilentlyContinue
          }		  
}		 

# People button - Windows 10 Redstone 3/FCU/b1709+
if ($pp["PEOPLE"] -ne $null -or $pp["PEOPLE"] -ne '')
     {
      if ($pp["PEOPLE"] -eq "yes" -or $pp["PEOPLE"] -eq "YES" -or $pp["PEOPLE"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Value 1 -ea SilentlyContinue
          } 
      if ($pp["PEOPLE"] -eq 'no' -or $pp["PEOPLE"] -eq 'NO' -or $pp["PEOPLE"] -eq 'No')
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Value 0 -ea SilentlyContinue
      	  }
}	 

# Task view button - Windows 10
if ($pp["TASKVIEW"] -ne $null -or $pp["TASKVIEW"] -ne '')
     {
      if ($pp["TASKVIEW"] -eq "yes" -or $pp["TASKVIEW"] -eq "YES" -or $pp["TASKVIEW"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value 1 -ea SilentlyContinue
          } 
      if ($pp["TASKVIEW"] -eq 'no' -or $pp["TASKVIEW"] -eq 'NO' -or $pp["TASKVIEW"] -eq 'No')
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value 0 -ea SilentlyContinue
          }
}	 

# Windows Store button - Windows 8+
if ($pp["STORE"] -ne $null -or $pp["STORE"] -ne '')
     {
      if ($pp["STORE"] -eq "yes" -or $pp["STORE"] -eq "YES" -or $pp["STORE"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "StoreAppsOnTaskbar" -Value 1 -ea SilentlyContinue
       	  } 
      if ($pp["STORE"] -eq 'no' -or $pp["STORE"] -eq 'NO' -or $pp["STORE"] -eq 'No')
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "StoreAppsOnTaskbar" -Value 0 -ea SilentlyContinue
      	  }
}	 
	 
# Windows Ink Workspace button - Windows 10
if ($pp["INK"] -ne $null -or $pp["INK"] -ne '')
     {
      if ($pp["INK"] -eq "yes" -or $pp["INK"] -eq "YES" -or $pp["INK"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\PenWorkspace" -Name "PenWorkspaceButtonDesiredVisibility" -Value 1 -ea SilentlyContinue
          } 
      if ($pp["INK"] -eq 'no' -or $pp["INK"] -eq 'NO' -or $pp["INK"] -eq 'No')
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\PenWorkspace" -Name "PenWorkspaceButtonDesiredVisibility" -Value 0 -ea SilentlyContinue
          }
}	 

# Windows touch keyboard button - Windows 10
if ($pp["KEYBOARD"] -ne $null -or $pp["KEYBOARD"] -ne '')
     {
      if ($pp["KEYBOARD"] -eq "yes" -or $pp["KEYBOARD"] -eq "YES" -or $pp["KEYBOARD"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\TabletTip\1.7" -Name "TipbandDesiredVisibility" -Value 1 -ea SilentlyContinue
          } 
      if ($pp["KEYBOARD"] -eq 'no' -or $pp["KEYBOARD"] -eq 'NO' -or $pp["KEYBOARD"] -eq 'No')
          {
            Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\TabletTip\1.7" -Name "TipbandDesiredVisibility" -Value 0 -ea SilentlyContinue
          }
}	 

# EnableAutoTray - Windows 7+
if ($pp["AUTOTRAY"] -ne $null -or $pp["AUTOTRAY"] -ne '')
     {
      if ($pp["AUTOTRAY"] -eq "yes" -or $pp["AUTOTRAY"] -eq "YES" -or $pp["AUTOTRAY"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Value 1 -ea SilentlyContinue
          } 
      if ($pp["AUTOTRAY"] -eq 'no' -or $pp["AUTOTRAY"] -eq 'NO' -or $pp["AUTOTRAY"] -eq 'No')
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Value 0 -ea SilentlyContinue
          }
}	

# Cortana  button - Windows 10
if ($pp["CORTANA"] -ne $null -or $pp["CORTANA"] -ne '')
     {
      if ($pp["CORTANA"] -eq "no" -or $pp["CORTANA"] -eq "NO" -or $pp["CORTANA"] -eq "No")
         {
          Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0 -ea SilentlyContinue
      	 } 
      if ($pp["CORTANA"] -eq 'icon' -or $pp["CORTANA"] -eq 'ICON' -or $pp["CORTANA"] -eq 'Icon')
         {
          Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 1 -ea SilentlyContinue
      	 }
      if ($pp["CORTANA"] -eq 'searchbar' -or $pp["CORTANA"] -eq 'SEARCHBAR' -or $pp["CORTANA"] -eq 'Searchbar')
         {
          Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 2 -ea SilentlyContinue
      	 }		 
}

# Start Menu - Windows 10 Redstone 2/CU/b1703+ use PowerShell or Command Prompt on right click Start 
if ($pp["USEPOWERSHELL"] -ne $null -or $pp["USEPOWERSHELL"] -ne '')
     {
      if ($pp["USEPOWERSHELL"] -eq "YES" -or $pp["USEPOWERSHELL"] -eq "yes" -or $pp["USEPOWERSHELL"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DontUsePowerShellOnWinX" -Value 0 -ea SilentlyContinue
          }
	  if ($pp["USEPOWERSHELL"] -eq 'NO' -or $pp["USEPOWERSHELL"] -eq 'no' -or $pp["USEPOWERSHELL"] -eq 'No')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DontUsePowerShellOnWinX" -Value 1 -ea SilentlyContinue
		  }
}

Stop-Process -ProcessName Explorer
