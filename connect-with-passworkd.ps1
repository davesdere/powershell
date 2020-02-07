
$username = "username@domain.com"
$password = ConvertTo-SecureString "mypassword" -AsPlainText -Force
$psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)
Import-Module MSOnline
Connect-MSolService -Credential $psCred
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://domain.com" -Credential $psCred -Authentication Basic -AllowRedirection 
Import-PSSession $Session -AllowClobber -DisableNameChecking