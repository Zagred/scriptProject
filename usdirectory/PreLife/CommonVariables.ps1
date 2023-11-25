#
# 20200512 Miro : Restructure/simplify variables and includes
#
$Global:configuration = "USD.PreLife"
$Global:projectPublishProfile = "USD.PreLife.pubxml"

$Global:svnRepoPath = @("svn://bgsvn01:3695/branches/PreLife")
$Global:branchFolder = @("D:\Projects\PreLife")

$Global:Server = "bgwebtest01.corp.shooger.com"
$Global:ServiceName = "Background Tasks service (Usd PreLife)"

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\USDCommon.ps1"
