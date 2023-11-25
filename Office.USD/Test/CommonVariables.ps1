#
# 20200512 Miro : Restructure/simplify variables and includes
#
$Global:configuration = "Office.USD.Test"
$Global:projectPublishProfile = "Office.USD.Test.pubxml"

$Global:svnRepoPath = @("svn://bgsvn01:3694/Branches/20230103","svn://bgsvn01:3695/trunk/shared/TasksLibrary","svn://bgsvn01:3695/trunk/shared/CSVUtilities","svn://bgsvn01:3695/trunk/shared/IPUtilities","svn://bgsvn01:3695/trunk/shared/GeoIP")
$Global:branchFolder = @("c:\Projects\AssetManager-Office", "c:\Projects\AssetManager-Office\TasksLibrary", "c:\Projects\AssetManager-Office\CSVUtilities", "c:\Projects\AssetManager-Office\IPUtilities", "c:\Projects\AssetManager-Office\GeoIP")

$Global:Server = "bgwebtest01.corp.shooger.com"
  
$parentPath  = (Get-Item $PSScriptRoot).Parent.Parent.FullName + "\uncut\"
. "$parentPath\UncutCommon.ps1"


