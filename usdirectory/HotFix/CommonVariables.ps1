#
# 20200512 Miro : Restructure/simplify variables and includes
#
$Global:configuration = "USD.Hotfix"
$Global:projectPublishProfile = "USD.HotFix.pubxml"

$Global:svnRepoPath = @("svn://bgsvn01:3695/branches/Hotfix")
$Global:branchFolder = @("D:\Projects\Hotfix")

$Global:Server = "usdn1.corp.shooger.com"

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\ShoogerCommonFile.ps1"