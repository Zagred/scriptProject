# 20200512 Miro : Restructure/simplify variables and includes
$Global:svnRepoPath = @("svn://bgsvn01:3695/branches/Hotfix")
$Global:branchFolder = @("c:\Projects\Hotfix")

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\CommonVariables.ps1"