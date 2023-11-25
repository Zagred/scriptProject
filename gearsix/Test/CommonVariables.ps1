#
# 2020123 Miro : Restructure/simplify variables and includes
#
$Global:configuration = "Test"
$Global:projectPublishProfile = "GearSix.Test.pubxml"

$Global:svnRepoPath = @("svn://svn.shooger.com:3694/Gearsix.io")
$Global:branchFolder = @("c:\Projects\gearsix.io")

$Global:Server = "BGWEBUNCUTEST01.uncut.local"
$Global:SiteName = "test.gearsix.io";

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\GearSixCommon.ps1"



