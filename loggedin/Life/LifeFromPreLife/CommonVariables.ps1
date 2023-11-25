# 20200512 Miro : Restructure/simplify variables and includes
$Global:svnRepoPath = @("svn://bgsvn01:3695/branches/PreLife")
$Global:branchFolder = @("D:\Projects\PreLife")

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\CommonVariables.ps1"




