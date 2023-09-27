#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest


if (-not (Test-Command gem) -and (-not (Get-Variable -Name PWSHRC_FORCE_MODULES_EXPORT_UNSUPPORTED -Scope Global -ValueOnly -ErrorAction SilentlyContinue))) {
    return
}

# Run sudo gem on the system ruby, not the active ruby
function Invoke-GemSystem {
    sudo gem @args
}
Set-Alias -Name sgem -Value Invoke-GemSystem
Export-ModuleMember -Function Invoke-GemSystem -Alias sgem

# Gem Command Shorthands
function Invoke-GemInstall {
    gem install @args
}
Set-Alias -Name gein -Value Invoke-GemInstall
Export-ModuleMember -Function Invoke-GemInstall -Alias gein

function Invoke-GemUninstall {
    gem uninstall @args
}
Set-Alias -Name geun -Value Invoke-GemUninstall
Export-ModuleMember -Function Invoke-GemUninstall -Alias geun

function Invoke-GemList {
    gem list @args
}
Set-Alias -Name geli -Value Invoke-GemList
Export-ModuleMember -Function Invoke-GemList -Alias geli

function Invoke-GemInfo {
    gem info @args
}
Set-Alias -Name gei -Value Invoke-GemInfo
Export-ModuleMember -Function Invoke-GemInfo -Alias gei

function Invoke-GemInfoAll {
    gem info --all @args
}
Set-Alias -Name geiall -Value Invoke-GemInfoAll
Export-ModuleMember -Function Invoke-GemInfoAll -Alias geiall

function Invoke-GemCertAdd {
    gem cert --add @args
}
Set-Alias -Name geca -Value Invoke-GemCertAdd
Export-ModuleMember -Function Invoke-GemCertAdd -Alias geca

function Invoke-GemCertRemove {
    gem cert --remove @args
}
Set-Alias -Name gecr -Value Invoke-GemCertRemove
Export-ModuleMember -Function Invoke-GemCertRemove -Alias gecr

function Invoke-GemCertBuild {
    gem cert --build @args
}
Set-Alias -Name gecb -Value Invoke-GemCertBuild
Export-ModuleMember -Function Invoke-GemCertBuild -Alias gecb

function Invoke-GemCleanupNo {
    gem cleanup -n @args
}
Set-Alias -Name geclup -Value Invoke-GemCleanupNo
Export-ModuleMember -Function Invoke-GemCleanupNo -Alias geclup

function Invoke-GemGenerateIndex {
    gem generate_index @args
}
Set-Alias -Name gegi -Value Invoke-GemGenerateIndex
Export-ModuleMember -Function Invoke-GemGenerateIndex -Alias gegi

function Invoke-GemHelp {
    gem help @args
}
Set-Alias -Name geh -Value Invoke-GemHelp
Export-ModuleMember -Function Invoke-GemHelp -Alias geh

function Invoke-GemLock {
    gem lock @args
}
Set-Alias -Name gel -Value Invoke-GemLock
Export-ModuleMember -Function Invoke-GemLock -Alias gel

function Invoke-GemOpen {
    gem open @args
}
Set-Alias -Name geo -Value Invoke-GemOpen
Export-ModuleMember -Function Invoke-GemOpen -Alias geo

function Invoke-GemOpenEditor {
    gem open -e @args
}
Set-Alias -Name geoe -Value Invoke-GemOpenEditor
Export-ModuleMember -Function Invoke-GemOpenEditor -Alias geoe

<#
.SYNOPSIS
    Removes installed gem.
.COMPONENT
    Ruby
#>
function Invoke-GemRemoveByPattern {
    param(
        [Parameter(Mandatory = $true, Position = 0, ParameterSetName = "NameMatch")]
        [ValidateNotNullOrEmpty()]
        [string] $NameMatch,

        [Parameter(Mandatory = $true, Position = 0, ParameterSetName = "NameLike")]
        [ValidateNotNullOrEmpty()]
        [string] $NameLike
    )
    [string[]] $matchingGems = @()
    if ($NameMatch) {
        $matchingGems = gem list | Where-Object {
            $_ -match $NameMatch
        }
    } elseif ($NameLike) {
        $matchingGems = gem list | Where-Object {
            $_ -like $NameLike
        }
    } else {
        throw "Invalid parameter set."
    }

    sudo gem uninstall @matchingGems
}
Set-Alias -Name remove_gem -Value Invoke-GemRemoveByPattern
Export-ModuleMember -Function Invoke-GemRemoveByPattern -Alias remove_gem
