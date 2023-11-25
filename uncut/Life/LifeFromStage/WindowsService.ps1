# 20220308 Miro : Copied from trunk script
#
$AutomaticVariables = Get-Variable

$ourPath =  (Get-Item $PSScriptRoot).FullName
. "$ourPath\CommonVariables.ps1"

# Everything for life windows service
$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\WindowsServiceCommon.ps1"

PublishWindowsService 

