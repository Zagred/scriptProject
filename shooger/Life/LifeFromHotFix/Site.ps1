# 20181030 Miro : Publich "HotFix" svn branch to shooger.com
# 20200513 Miro : Restructure/simplify variables and includes
#
$AutomaticVariables = Get-Variable

$ourPath =  (Get-Item $PSScriptRoot).FullName
. "$ourPath\CommonVariables.ps1"

# Everything for life site
$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\SiteCommon.ps1"

PublishSite