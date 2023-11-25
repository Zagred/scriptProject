# 20181023 Miro : Publich "Trunk" svn branch to test.shoogerservices.com
# 20200513 Miro : Restructure/simplify variables and includes
#
$AutomaticVariables = Get-Variable

$ourPath =  (Get-Item $PSScriptRoot).FullName
. "$ourPath\CommonVariables.ps1"

# Everything for life windows service
$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\WindowsServiceCommon.ps1"

PublishWindowsService 
