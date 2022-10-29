$scripts = Get-ChildItem ~\Documents\WindowsPowerShell\commands\* -name
$ScriptCounter = 0
$helpCommand = "function global:ehelp{`n"
$definer = ""
foreach ($script in $scripts) {
  $ScriptCounter += 1
  $ScriptName =   [regex]::Replace(($script -replace ".ps1", ""), "(?:^|(?<=-))(\w)", { $args.groups[1].value.toupper() })

  $mainScript = Get-Content ~\Documents\WindowsPowerShell\commands\$script -raw
  $definer += @"
  function global:$ScriptName {
    $mainScript
  }
"@
  $helpCommand += "write-host $ScriptName  -ForegroundColor blue`n"
}
$helpCommand += "}"
Invoke-Expression $helpCommand
Invoke-Expression $definer
