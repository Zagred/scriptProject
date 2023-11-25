# 20200512 Miro : Restructure/simplify variables and includes


$Global:configuration = "Release"
$Global:projectPublishProfile = "HandsdownStudios.Release.pubxml"

$Global:svnRepoPath = @("svn://bgsvn01:3694/HandsdownStudios")
$Global:branchFolder = @("c:\Projects\HandsdownStudios")

$Global:Server = "USWEBUNCUTPRD01.uncut.local"
$Global:SiteName = "www.handsdownstudios.com";

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\Common.ps1"

