# AWS Secret Manager Poutine
$secret_manager = Get-SECSecretValue -SecretId 'arn:aws:secretsmanager:${AWS::Region}:${AWS::AccountId}:secret:name-of-secret'
# Parse the response and convert the Secret String JSON into an object
$secret = $secret_manager.SecretString | ConvertFrom-Json
$somekey = $secret.key
echo Got the encoded license
$somekey = $somekey -replace '\s',''
echo Trimmed spaces
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($somekey)) | Out-File -FilePath c:\artefacts\artefact.txt
echo Pulled, unencrypt and decoded secret