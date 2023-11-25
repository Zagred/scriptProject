#
# 20200512 Miro : Restructure/simplify variables and includes
#
$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\ShoogerCommonFile.ps1"

$Global:configuration = "Shooger.Hotfix"
$Global:projectPublishProfile = "Shooger.HotFix.pubxml"

$Global:svnRepoPath = @("svn://bgsvn01:3695/branches/Hotfix")
$Global:branchFolder = @("D:\Projects\Hotfix")

$Global:Server = "db4.corp.shooger.com"

