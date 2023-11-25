# 20200512 Miro : Restructure/simplify variables and includes
$Global:svnRepoPath = @("svn://bgsvn01:3695/Trunk")
$Global:branchFolder = @("D:\Projects\Trunk")

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\CommonVariables.ps1"


