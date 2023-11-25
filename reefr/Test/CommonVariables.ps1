#
# 20200512 Miro : Restructure/simplify variables and includes
#
$Global:configuration = "Reefr.Test"
$Global:projectPublishProfile = "Reefr.Test.pubxml"

$Global:svnRepoPath = @("svn://bgsvn01:3695/trunk/")
$Global:branchFolder = @("D:\Projects\trunk")

$Global:Server = "bgwebtest01.corp.shooger.com"

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\ReefrCommon.ps1"




