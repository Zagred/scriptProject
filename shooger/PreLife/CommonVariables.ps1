#
# 20200512 Miro : Restructure/simplify variables and includes
#
$Global:configuration = "Shooger.PreLife"
$Global:projectPublishProfile = "Shooger.PreLife.pubxml"

$Global:svnRepoPath = @("svn://bgsvn01:3695/branches/PreLife/")
$Global:branchFolder = @("D:\Projects\PreLife")

$Global:Server = "bgwebtest01.corp.shooger.com"
$Global:ServiceName = "Background Tasks service (Usd Shooger)"

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\ShoogerCommonFile.ps1"