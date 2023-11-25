#
# 20200512 Miro : Restructure/simplify variables and includes
#
$Global:configuration = "Uncut.Test"
$Global:projectPublishProfile = "Uncut.Test.pubxml"

$Global:svnRepoPath = @("svn://bgsvn01:3694/AssetManager","svn://bgsvn01:3695/trunk/shared/TasksLibrary","svn://bgsvn01:3695/trunk/shared/CSVUtilities","svn://bgsvn01:3695/trunk/shared/IPUtilities","svn://bgsvn01:3695/trunk/shared/GeoIP")
$Global:branchFolder = @("c:\Projects\AssetManager", "c:\Projects\AssetManager\TasksLibrary", "c:\Projects\AssetManager\CSVUtilities", "c:\Projects\AssetManager\IPUtilities", "c:\Projects\AssetManager\GeoIP")

$Global:Server = "BGWEBUNCUTEST01.uncut.local"
  
$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\UncutCommon.ps1"


