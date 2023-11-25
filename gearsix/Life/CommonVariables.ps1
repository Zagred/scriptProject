#
# 2020123 Miro : Restructure/simplify variables and includes
#
$Global:configuration = "Release"
$Global:projectPublishProfile = "GearSix.Release.pubxml"

$Global:svnRepoPath = @("svn://svn.shooger.com:3694/Gearsix.io")
$Global:branchFolder = @("c:\Projects\gearsix.io")

$Global:Server = "USWEBUNCUTPRD01.uncut.local"
$Global:SiteName = "gearsix.io";

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\GearSixCommon.ps1"



