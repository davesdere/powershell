# https://docs.aws.amazon.com/powershell/latest/userguide/pstools-getting-set-up-windows.html#ps-installing-awspowershellnetcore

# After copying this script make sure to Run As Admin
# Set-ExecutionPolicy RemoteSigned 

# Make sure the proper libraries are installed
Install-Module -name AWSPowerShell.NetCore
# Check its there
Get-Module -ListAvailable

# If you're running PowerShell as administrator, the previous command installs AWS Tools for PowerShell for all users on the computer. If you're running PowerShell as a standard user without administrator permissions, that same command installs AWS Tools for PowerShell for only the current user.
# You could scope it differently with # Install-Module -name AWSPowerShell.NetCore -Scope CurrentUser
# Once done, import the librarie because its too large to automatically load
Import-Module AWSPowerShell.NetCore

$BucketName = "myS3Bucket"
$s3Directory = "C:\users\$env:username\documents\s3test"
$concurrentLimit = 5
$inProgressFiles = @()

foreach ($i in Get-ChildItem $s3Directory)
{
# Write the file to S3 and add the filename to a collection.
Write-S3Object -BucketName $BucketName -Key $i.Name -File $i.FullName
$inProgressFiles += $i.Name

# Wait to continue iterating through files if there are too many concurrent uploads
while($inProgressFiles.Count -gt $concurrentLimit)
{
Write-Host "Before: "$($inProgressFiles.Count)

# Reassign the array by excluding files that have completed the upload to S3.
$inProgressFiles = @($inProgressFiles | ? { @(get-s3object -BucketName $BucketName -Key $_).Count -eq 0 })

Write-Host "After: "$($inProgressFiles.Count)

Start-Sleep -s 1
}
Start-Sleep -s 1
}
