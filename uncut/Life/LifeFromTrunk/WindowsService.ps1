# 20181031 Miro : Publish life service
# 20200330 Miro : Adjust script to transfer in usd server usdn1 
# 20200730 Miro : Restructure/simplify variables and includes
#
$AutomaticVariables = Get-Variable

$ourPath =  (Get-Item $PSScriptRoot).FullName
. "$ourPath\CommonVariables.ps1"

# Everything for life windows service
$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\WindowsServiceCommon.ps1"

PublishWindowsService 

