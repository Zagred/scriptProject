# 20200330 Miro 
# 20200730 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$ourPath =  (Get-Item $PSScriptRoot).FullName
. "$ourPath\CommonVariables.ps1"

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\ProcessorsCommon.ps1"

PublishProcessors


