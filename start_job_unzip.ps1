# Start Job, Unzip
Start-job -scriptblock { Expand-Archive -LiteralPath c:\artefacts.zip -DestinationPath c:\artefacts } -name "Extract-Artefacts"
Wait-job -name "Extract-Artefacts"