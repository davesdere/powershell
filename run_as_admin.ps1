# Run as Admin
echo $env:UserName $env:ComputerName $env:UserDomain | Out-File .\test.log
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
exit;
}
Start-job -scriptblock { Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command c:\path\to\command.bat argument1 argumentn" } -name "Run-installer"
Wait-job -name "Run-installer"
Wait-Process -name cmd; Get-Date | Out-File C:\artefacts\artefact.log
echo Done
# Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command c:\path\to\command.bat argument1 argumentn"