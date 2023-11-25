# 20181030 Miro : Publich "Trunk" svn branch to shooger.com
# 20200513 Miro : Restructure/simplify variables and includes
#
$AutomaticVariables = Get-Variable

$ourPath =  (Get-Item $PSScriptRoot).FullName
. "$ourPath\CommonVariables.ps1"

# Everything for life media site
$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\MediaCommon.ps1"

PublishSite