# Check get-myCreds.ps1 and export-creds.ps1 to use this
$Credentials = Get-MyCredential (join-path ($PsScriptRoot) Syncred.xml)