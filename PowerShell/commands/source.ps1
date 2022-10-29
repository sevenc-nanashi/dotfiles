Param($file = ".env")
$DB = Get-Content $file
$EnvCount = 0
$CommentCount = 0
$CommandCount = 0
foreach ($Data in $DB) {
  If ($Data -match "^#") {
    $CommentCount += 1
    continue
  }
  Elseif ($Data -match "^.+=.+") {
    $EnvCount += 1
    $Name, $Value = $Data.split("=", 2)
    [Environment]::SetEnvironmentVariable($Name, $Value, "Process")
  }
  else {
    $CommandCount+=1
    Invoke-Expression $Data
  }
}
write-host "Loaded " -NoNewline 
write-host $EnvCount -NoNewline -ForegroundColor Cyan
write-host " Variable(s), " -NoNewline 
write-host "Executed " -NoNewline 
write-host $CommandCount -NoNewline -ForegroundColor Cyan
write-host " Command(s), " -NoNewline 
write-host "Skipped " -NoNewline 
write-host $CommentCount -NoNewline -ForegroundColor Cyan
write-host " Line(s)."