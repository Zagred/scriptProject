#
# 20200512 Miro : Restructure/simplify variables and includes
#
$Global:configuration = "Office.USD.Release"
$Global:projectPublishProfile = "Office.USD.Release.pubxml"

#$Global:svnRepoPath = @("svn://bgsvn01:3694/AssetManager","svn://bgsvn01:3695/trunk/shared/TasksLibrary","svn://bgsvn01:3695/trunk/shared/CSVUtilities","svn://bgsvn01:3695/trunk/shared/IPUtilities","svn://bgsvn01:3695/trunk/shared/GeoIP")
# release from branch LibreOffice
$Global:svnRepoPath = @("svn://bgsvn01:3694/Branches/20230103","svn://bgsvn01:3695/trunk/shared/TasksLibrary","svn://bgsvn01:3695/trunk/shared/CSVUtilities","svn://bgsvn01:3695/trunk/shared/IPUtilities","svn://bgsvn01:3695/trunk/shared/GeoIP")
$Global:branchFolder = @("c:\Projects\AssetManager-Office", "c:\Projects\AssetManager-Office\TasksLibrary", "c:\Projects\AssetManager-Office\CSVUtilities", "c:\Projects\AssetManager-Office\IPUtilities", "c:\Projects\AssetManager-Office\GeoIP")

$Global:Server = "usdn1.corp.shooger.com"
  
$parentPath  = (Get-Item $PSScriptRoot).Parent.Parent.FullName + "\uncut\"
. "$parentPath\UncutCommon.ps1"


