# 20200512 Miro : Restructure/simplify variables and includes
$Global:svnRepoPath = @("svn://bgsvn01:3695/Trunk")
$Global:branchFolder = @("c:\Projects\Trunk")

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\CommonVariables.ps1"