# 20181030 Miro : Publich "PreLife" svn branch to shooger.com
# 20200512 Miro : Restructure/simplify variables and includes
$AutomaticVariables = Get-Variable

$ourPath =  (Get-Item $PSScriptRoot).FullName
$parent =  (Get-Item $PSScriptRoot).Parent.FullName
. "$ourPath\CommonVariables.ps1"
. "$parent\SiteCommon.ps1"

PublishSite