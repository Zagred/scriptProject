#
# 20200512 Miro : Restructure/simplify variables and includes
#
$Global:configuration = "Test"
$Global:projectPublishProfile = "HandsdownStudios.Test.pubxml"

$Global:svnRepoPath = @("svn://svn.shooger.com:3694/HandsdownStudios")
$Global:branchFolder = @("c:\Projects\HandsdownStudios")

$Global:Server = "BGWEBUNCUTEST01.uncut.local"
$Global:SiteName = "test.handsdownstudios.com";

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\Common.ps1"




