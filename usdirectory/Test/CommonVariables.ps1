#
# 20200512 Miro : Restructure/simplify variables and includes
#
$Global:configuration = "USD.Test"
$Global:projectPublishProfile = "USD.Test.pubxml"

$Global:svnRepoPath = @("svn://bgsvn01:3695/trunk/")
$Global:branchFolder = @("c:\Projects\trunk")

$Global:Server = "bgwebtest01.corp.shooger.com"

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\USDCommon.ps1"





