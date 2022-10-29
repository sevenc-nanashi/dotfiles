using namespace System.Management.Automation

<# Options include:
     RelativeFilePaths - [bool]
         Always resolve file paths using Resolve-Path -Relative.
         The default is to use some heuristics to guess if relative or absolute is better.

   To customize your own custom options, pass a hashtable to CompleteInput, e.g.
         return [System.Management.Automation.CommandCompletion]::CompleteInput($inputScript, $cursorColumn,
             @{ RelativeFilePaths=$false }
#>

function TabExpansion2 {
    [CmdletBinding(DefaultParameterSetName = 'ScriptInputSet')]
    Param(
        [Parameter(ParameterSetName = 'ScriptInputSet', Mandatory = $true, Position = 0)]
        [string] $inputScript,

        [Parameter(ParameterSetName = 'ScriptInputSet', Mandatory = $true, Position = 1)]
        [int] $cursorColumn,

        [Parameter(ParameterSetName = 'AstInputSet', Mandatory = $true, Position = 0)]
        [System.Management.Automation.Language.Ast] $ast,

        [Parameter(ParameterSetName = 'AstInputSet', Mandatory = $true, Position = 1)]
        [System.Management.Automation.Language.Token[]] $tokens,

        [Parameter(ParameterSetName = 'AstInputSet', Mandatory = $true, Position = 2)]
        [System.Management.Automation.Language.IScriptPosition] $positionOfCursor,

        [Parameter(ParameterSetName = 'ScriptInputSet', Position = 2)]
        [Parameter(ParameterSetName = 'AstInputSet', Position = 3)]
        [Hashtable] $options = $null
    )

    End
    {
        if ($psCmdlet.ParameterSetName -eq 'ScriptInputSet')
        {
            $result = [System.Management.Automation.CommandCompletion]::CompleteInput(
                <#inputScript#>  $inputScript,
                <#cursorColumn#> $cursorColumn,
                <#options#>      $options)
            if (Test-Path '.\.git') {
                $candidates = @{
                    add = 'git add ';
                    gac = 'git add -A; git commit -m ';
                    commit = 'git commit -m ';
                    push = 'git push';
                    branch = 'git branch ';
                    log = 'git log';
                    status = 'git status';
                    show = 'git show ';
                    diff = 'git diff';
                    checkout = 'git checkout ';
                    pull = 'git pull';
                    fetch = 'git fetch';
                    merge = 'git merge ';
                    rebase = 'git rebase '
                }
                $matches = $candidates.Keys | Where-Object {
                    $_.StartsWith($inputScript)
                }
                if ($matches -ne $null) {
                    $matches | Foreach-Object {
                        $result.CompletionMatches.Insert(0, [CompletionResult]::new($candidates[$_]))
                    }
                }
            }
            return $result;
        }
        else
        {
            return [System.Management.Automation.CommandCompletion]::CompleteInput(
                <#ast#>              $ast,
                <#tokens#>           $tokens,
                <#positionOfCursor#> $positionOfCursor,
                <#options#>          $options)
        }
    }
}

Export-ModuleMember -Function TabExpansion2
