if ($PSVersionTable.PSVersion.Major -ne 7) {
  Exit
}
$coreutils = @("rm", "cp", "mv", "tail", "head", "stat", "du", "ln")
foreach ($cmd in $coreutils) {
  if (Test-Path "alias:$cmd") {
    Remove-Item "alias:$cmd" -Force
  }

  $functionName = $cmd
  $functionBody = {
    coreutils $MyInvocation.MyCommand.Name @args
  }.GetNewClosure()

  Set-Item "function:$functionName" $functionBody
}

if (Test-Path alias:ni) {
  Remove-Item alias:ni -Force
  Remove-Item alias:ri -Force
}
Set-Alias ls eza
Set-Alias cat bat
function global:ll {
  eza -al @args
}

[Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Set-Alias rb ruby
Set-Alias ipy ipython
function bfg {
  java -jar ~\Documents\PowerShell\resources\bfg-1.14.0.jar $args
}
function global:badb {
  & "C:\Program Files\BlueStacks_nxt\HD-Adb.exe" $args
}
$OutputEncoding = [System.Text.Encoding]::GetEncoding('utf-8')
$env:ChocolateyInstall = "C:\ProgramData\chocolatey"
$env:RUBY_DLL_PATH = 'C:/Program Files/PostgreSQL/13/bin/'
$env:VIRTUAL_ENV_DISABLE_PROMPT = 1
$token = (Get-Content -Path ~\Documents\PowerShell\resources\discord_bot_token.txt -Raw)
$env:DISCORD_BOT_TOKEN = $token
$dauth = "Authorization: Bot $token"
$dauth | Out-Null
$env:PYTHONSTARTUP = "$HOME/.pythonrc"
$global:venv_prev_path = ""
$env:path = [System.Environment]::GetEnvironmentVariable("path", "machine") + ";" + [System.Environment]::GetEnvironmentVariable("path", "user")
# invoke-expression (get-content ~\Documents\PowerShell\commands\reload-commands.ps1 -Raw)

Invoke-Expression -Command $(gh completion -s powershell | Out-String)

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-PSReadLineOption -ContinuationPrompt '  '

function global:rex {
  if ($args[0] -and (Test-path $args[0])) {
    bundle exec ruby $args
  }
  else {
    bundle exec $args
  }
}

function global:pex {
  if ($args[0] -and (Test-path $args[0])) {
    poetry run python $args
  }
  else {
    poetry run $args
  }
}

function global:mcd {
  Param(
    [string]$path
  )
  mkdir $path
  Set-Location $path
}

function global:npr {
  npm run $args
}

function global:pop {
  poetry poe $args
}

function global:Show-Toast {
  Param([String]$content)
  powershell -noprofile -command @"

`$AppId = ""{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe"""";
`$template=[Windows.UI.Notifications.ToastNotificationManager,Windows.UI.Notifications, ContentType = WindowsRuntime]::GetTemplateContent(
  [Windows.UI.Notifications.ToastTemplateType, Windows.UI.Notifications, ContentType = WindowsRuntime]::ToastText01);
`$template.GetElementsByTagName(""text"""").Item(0).InnerText=""$($content -replace "`"","```"" )"""";
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier(`$AppId).Show(`$template);
"@

}
Invoke-Expression (&starship init powershell)

# Invoke-Expression "$(thefuck --alias f)"

function global:ccat {
  Param(
    [parameter(mandatory)][string]$path
  )
  pygmentize -g $path
}

function global:r2j {
  $result = ruby -r json -r clipboard -e 'puts JSON.pretty_generate(eval(Clipboard.paste.encode(\"UTF-8\")))'
  Write-Output $result
  Set-Clipboard $result
}

function global:ffgif {
  Param(
    [parameter(mandatory)][string]$path,
    [parameter(mandatory)][string]$dist,
    [int32]$fps = 10
  )
  ffmpeg -i $path -filter_complex "[0:v] fps=$fps,split [a][b];[a] palettegen [p];[b][p] paletteuse" $dist
}

function global:ffnvenc {
  Param(
    [parameter(mandatory)][string]$path,
    [parameter(mandatory)][string]$dist
  )
  ffmpeg -i $path -c:v h264_nvenc  -profile:v high  -tune hq -rc-lookahead 8 -bf 2 -rc vbr -cq 26 -b:v 0 -maxrate 120M -bufsize 240M $dist
}

function global:Stop-ProcessByPort {
  Param(
    [parameter(mandatory)][int32]$port
  )
  $process = Get-Process -Id (Get-NetTCPConnection -LocalPort $port).OwningProcess

  if ((read-host "Stop process `"$($process.ProcessName)`" [$($process.Id)]? [y/N] ") -eq "y") {
    Stop-Process $process
  }
}

function global:docker-export {
  Param(
    [parameter(mandatory)][string]$image,
    [parameter(mandatory)][string]$dist
  )
  $nonce = [Guid]::NewGuid().ToString("N")
  docker create --name="tmp_$nonce" $image
  docker export tmp_$nonce -o $dist
  docker rm tmp_$nonce
}

function global:rbswitch {
  Param(
    [switch]$31,
    [switch]$32
  )
  
  $original_path = $env:PATH
  if ($31) {
    $env:PATH = $original_path.ToLower().replace("\ruby32\", "\ruby31\")
  }
  else {
    $env:PATH = $original_path.ToLower().replace("\ruby31\", "\ruby32\")
  }
  Write-Output "Switched: $(ruby -v)"
}

function global:mklink {
  Param(
    [parameter(mandatory)][string]$from,
    [parameter(mandatory)][string]$to
  )
  $fromItem = Get-Item $from
  if ((Test-Path $to) -and (Get-Item $to).PSIsContainer) {
    $toPath = Join-Path $to $fromItem.Name
  }
  else {
    $toPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($to)
  }
  $fromPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($from)
  if ($fromItem.PSIsContainer) {
    cmd.exe /c mklink /J `"$toPath`" `"$fromPath`"
  }
  else {
    cmd.exe /c mklink `"$toPath`" `"$fromPath`"
  }
}

if ($env:TERM_PROGRAM -eq "vscode") { . "$(code --locate-shell-integration-path pwsh)" }

function Invoke-Starship-PreCommand {
  if ($global:venv_prev_path -ne ((Get-Location).toString())) {
    if ((Test-Path .venv) -and !(Test-Path env:VIRTUAL_ENV)) {
      if (Test-Path .venv/scripts/activate.ps1) {
        .venv/scripts/activate.ps1
      }
    }
    elseif (Test-Path env:VIRTUAL_ENV) {
      $venv_path = ($env:VIRTUAL_ENV -replace "/", "\").split("\")
      $venv_path = $venv_path[0..($venv_path.length - 2)] -join "\"
      if (!(Get-Location).toString().StartsWith($venv_path)) {
        deactivate
      }
    }
    $global:venv_prev_path = (Get-Location).toString()
  }
}
Import-Module posh-git
Import-Module posh-cargo

Set-PSReadLineOption -Colors @{ "Parameter" = "`e[92m"; "Number" = "`e[94m"; "Default" = "`e[0m" }

function global:Enable-VsDev {
  $vsPath = &(Join-Path ${env:ProgramFiles(x86)} "\Microsoft Visual Studio\Installer\vswhere.exe") -property installationpath
  Import-Module (Get-ChildItem $vsPath -Recurse -File -Filter Microsoft.VisualStudio.DevShell.dll).FullName
  Enter-VsDevShell -VsInstallPath $vsPath -SkipAutomaticLocation
}
