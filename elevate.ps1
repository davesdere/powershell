# Elevate as admin
Invoke-Command -ComputerName $env:COMPUTERNAME -ScriptBlock {Add-LocalGroupMember -Group "Administrators" -Member "$env:UserName"} -Credential $credential