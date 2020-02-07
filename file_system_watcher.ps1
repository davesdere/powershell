$FileSystemWatcher = New-Object System.IO.FileSystemWatcher
$FileSystemWatcher | Get-Member -Type Properties,Event
$FileSystemWatcherParams = @{

  Path = 'C:\test_powershell'

  Recurse =  $True

  NotifyFilter =  'FileName'

  Verbose =  $True

  Action=  {

  $Item  = Get-Item $Event.SourceEventArgs.FullPath

  $WriteHostParams  = @{

  ForegroundColor = 'Green'

  BackgroundColor = 'Black'

  }            

  Switch  -regex ($Item.Extension) {

  '\.(ps1|psm1|psd1)'  {$WriteHostParams.Object  = "Processing  PowerShell file: $($Item.Name)"}

  '\.(docx|doc)'  {$WriteHostParams.Object  = "Processing  Word document: $($Item.Name)"}

  '\.(xlsx|xls)'  {$WriteHostParams.Object  = "Processing  Excel spreadsheet: $($Item.Name)"}

  '\.csv'  {$WriteHostParams.Object  = "Processing  CSV spreadsheet: $($Item.Name)"}

  '\.xml'  {$WriteHostParams.Object  = "Processing  XML document: $($Item.Name)"}

  '\.exe'  {$WriteHostParams.Object  = "Processing  Executable: $($Item.Name)"}

  '\.onepkg'  {$WriteHostParams.Object  = "Processing  OneNote package: $($Item.Name)"}

  '\.lnk'  {$WriteHostParams.Object  = "Processing  Link: $($Item.Name)"}

  '\.cer|\.pfx'  {$WriteHostParams.Object  = "Processing  Certificate File: $($Item.Name)"}

  Default{$WriteHostParams.Object  = "Processing  File: $($Item.Name)"}

  }   

  $Item  | Remove-Item

  Write-Host  @WriteHostParams 

  }

}
@('Created') | ForEach {

  $FileSystemWatcherParams.EventName = $_

  Start-FileSystemWatcher  @FileSystemWatcherParams

}

