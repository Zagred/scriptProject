# 20181030 Miro : Publich "Trunk" svn branch to shooger.com
# 20200513 Miro : Restructure/simplify variables and includes
#
$AutomaticVariables = Get-Variable

$ourPath =  (Get-Item $PSScriptRoot).FullName
. "$ourPath\CommonVariables.ps1"

# Everything for life web services 
$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\WebServiceCommon.ps1"

PublishSite