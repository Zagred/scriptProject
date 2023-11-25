# 20220308 Miro : Copied from trunk script

$AutomaticVariables = Get-Variable

$ourPath =  (Get-Item $PSScriptRoot).FullName
. "$ourPath\CommonVariables.ps1"

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\ProcessorsCommon.ps1"

PublishProcessors


