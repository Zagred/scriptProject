#
# 20200512 Miro : Restructure/simplify variables and includes
#
$Global:configuration = "Safeco.Test"
$Global:projectPublishProfile = "Safeco.Test.pubxml"

$Global:svnRepoPath = @("svn://bgsvn01:3695/trunk/")
$Global:branchFolder = @("D:\Projects\trunk")

$Global:Server = "bgwebtest01.corp.shooger.com"

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\SafecoCommon.ps1"







