# Disable UAC
Start-Process -FilePath powershell.exe -ArgumentList { New-ItemProperty -Path HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -PropertyType DWord -Value 0 -Force } -verb RunAs