#
# 20200512 Miro : Restructure/simplify variables and includes
#
$Global:configuration = "Loggedin.PreLife"
$Global:projectPublishProfile = "Loggedin.PreLife.pubxml"

$Global:svnRepoPath = @("svn://bgsvn01:3695/branches/PreLife/")
$Global:branchFolder = @("D:\Projects\PreLife")

$Global:Server = "bgwebtest01.corp.shooger.com"

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\LoggedInCommon.ps1"

