$ErrorActionPreference = 'Stop'
$packageName = 'taskbar-winconfig'
$pp          = Get-PackageParameters

# Taskbar icon size
if ($pp["SIZE"] -ne $null -or $pp["SIZE"] -ne '')
     {
      if ($pp["SIZE"] -eq "big" -or $pp["SIZE"] -eq "BIG" -or $pp["SIZE"] -eq "Big")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSmallIcons" -Value 0
          }
	  if ($pp["SIZE"] -eq 'small' -or $pp["SIZE"] -eq 'SMALL' -or $pp["SIZE"] -eq 'Small')
	      {
	       Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSmallIcons" -Value 1
		  }
}

# Taskbar location
if ($pp["LOCATION"] -ne $null -or $pp["LOCATION"] -ne '')
     {
	   if ($pp["LOCATION"] -eq 'bottom' -or $pp["LOCATION"] -eq 'BOTTOM' -or $pp["LOCATION"] -eq 'Bottom')
	     {
	      Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" -Name Settings -Value ([byte[]] (0x28,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0x02,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x3e,0x00,0x00,0x00,0x2e,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x82,0x04,0x00,0x00,0x80,0x07,0x00,0x00,0xb0,0x04,0x00,0x00))
		 }
	   if ($pp["LOCATION"] -eq 'top' -or $pp["LOCATION"] -eq 'TOP' -or $pp["LOCATION"] -eq 'Top')
	     {
	      Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" -Name Settings -Value ([byte[]] (0x28,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0x02,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x3e,0x00,0x00,0x00,0x2e,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x80,0x07,0x00,0x00,0x2e,0x00,0x00,0x00))
		 }
	   if ($pp["LOCATION"] -eq 'left' -or $pp["LOCATION"] -eq 'LEFT' -or $pp["LOCATION"] -eq 'Left')
	     {
	      Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" -Name Settings -Value ([byte[]] (0x28,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0x02,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x3e,0x00,0x00,0x00,0x2e,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x3e,0x00,0x00,0x00,0xb0,0x04,0x00,0x00))
		 }
	   if ($pp["LOCATION"] -eq 'right' -or $pp["LOCATION"] -eq 'RIGHT' -or $pp["LOCATION"] -eq 'Right')
	     {
	      Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" -Name Settings -Value ([byte[]] (0x28,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0x02,0x00,0x00,0x00,0x02,0x00,0x00,0x00,0x3e,0x00,0x00,0x00,0x2e,0x00,0x00,0x00,0x42,0x07,0x00,0x00,0x00,0x00,0x00,0x00,0x80,0x07,0x00,0x00,0xb0,0x04,0x00,0x00))
		 }		 
	 }

# Taskbar lock
if ($pp["LOCKED"] -ne $null -or $pp["LOCKED"] -ne '')
     {
      if ($pp["LOCKED"] -eq "yes" -or $pp["LOCKED"] -eq "YES" -or $pp["LOCKED"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSizeMove" -Value 0
          } 
      if ($pp["LOCKED"] -eq 'no' -or $pp["LOCKED"] -eq 'NO' -or $pp["LOCKED"] -eq 'No')
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSizeMove" -Value 1
      	  }
}

# Combine icons
if ($pp["COMBINED"] -ne $null -or $pp["COMBINED"] -ne '')
     {
      if ($pp["COMBINED"] -eq "yes" -or $pp["COMBINED"] -eq "YES" -or $pp["COMBINED"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarGlomLevel" -Value 0
          } 
      if ($pp["COMBINED"] -eq 'full' -or $pp["COMBINED"] -eq 'FULL' -or $pp["COMBINED"] -eq 'Full')
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarGlomLevel" -Value 1
          }
      if ($pp["COMBINED"] -eq 'no' -or $pp["COMBINED"] -eq 'NO' -or $pp["COMBINED"] -eq 'No')
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarGlomLevel" -Value 2
          }		  
}		 

# People button
if ($pp["PEOPLE"] -ne $null -or $pp["PEOPLE"] -ne '')
     {
      if ($pp["PEOPLE"] -eq "yes" -or $pp["PEOPLE"] -eq "YES" -or $pp["PEOPLE"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Value 1
          } 
      if ($pp["PEOPLE"] -eq 'no' -or $pp["PEOPLE"] -eq 'NO' -or $pp["PEOPLE"] -eq 'No')
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Value 0
      	  }
}	 

# Task view button
if ($pp["TASKVIEW"] -ne $null -or $pp["TASKVIEW"] -ne '')
     {
      if ($pp["TASKVIEW"] -eq "yes" -or $pp["TASKVIEW"] -eq "YES" -or $pp["TASKVIEW"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value 1
          } 
      if ($pp["TASKVIEW"] -eq 'no' -or $pp["TASKVIEW"] -eq 'NO' -or $pp["TASKVIEW"] -eq 'No')
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value 0
          }
}	 

# Windows Store button
if ($pp["STORE"] -ne $null -or $pp["STORE"] -ne '')
     {
      if ($pp["STORE"] -eq "yes" -or $pp["STORE"] -eq "YES" -or $pp["STORE"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "StoreAppsOnTaskbar" -Value 1
       	  } 
      if ($pp["STORE"] -eq 'no' -or $pp["STORE"] -eq 'NO' -or $pp["STORE"] -eq 'No')
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "StoreAppsOnTaskbar" -Value 0
      	  }
}	 
	 
# Windows Ink Workspace button
if ($pp["INK"] -ne $null -or $pp["INK"] -ne '')
     {
      if ($pp["INK"] -eq "yes" -or $pp["INK"] -eq "YES" -or $pp["INK"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\PenWorkspace" -Name "PenWorkspaceButtonDesiredVisibility" -Value 1
          } 
      if ($pp["INK"] -eq 'no' -or $pp["INK"] -eq 'NO' -or $pp["INK"] -eq 'No')
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\PenWorkspace" -Name "PenWorkspaceButtonDesiredVisibility" -Value 0
          }
}	 

# Windows touch keyboard button
if ($pp["KEYBOARD"] -ne $null -or $pp["KEYBOARD"] -ne '')
     {
      if ($pp["KEYBOARD"] -eq "yes" -or $pp["KEYBOARD"] -eq "YES" -or $pp["KEYBOARD"] -eq "Yes")
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\TabletTip\1.7" -Name "TipbandDesiredVisibility" -Value 1
          } 
      if ($pp["KEYBOARD"] -eq 'no' -or $pp["KEYBOARD"] -eq 'NO' -or $pp["KEYBOARD"] -eq 'No')
          {
           Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\TabletTip\1.7" -Name "TipbandDesiredVisibility" -Value 0
          }
}	 
	 
# Cortana  button
if ($pp["CORTANA"] -ne $null -or $pp["CORTANA"] -ne '')
     {
      if ($pp["CORTANA"] -eq "no" -or $pp["CORTANA"] -eq "NO" -or $pp["CORTANA"] -eq "No")
         {
          Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0
      	 } 
      if ($pp["CORTANA"] -eq 'icon' -or $pp["CORTANA"] -eq 'ICON' -or $pp["CORTANA"] -eq 'Icon')
         {
          Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 1
      	 }
      if ($pp["CORTANA"] -eq 'searchbar' -or $pp["CORTANA"] -eq 'SEARCHBAR' -or $pp["CORTANA"] -eq 'Searchbar')
         {
          Set-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 2
      	 }		 
}	 
	 
Stop-Process -ProcessName Explorer
