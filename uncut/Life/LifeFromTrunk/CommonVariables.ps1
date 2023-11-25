# 20200730 Miro : Restructure/simplify variables and includes

$Global:svnRepoPath = @("svn://bgsvn01:3694/AssetManager","svn://bgsvn01:3695/trunk/shared/TasksLibrary", "svn://bgsvn01:3695/trunk/shared/CSVUtilities","svn://bgsvn01:3695/trunk/shared/IPUtilities","svn://bgsvn01:3695/trunk/shared/GeoIP")
$Global:branchFolder = @("c:\Projects\AssetManager\", "c:\Projects\AssetManager\TasksLibrary\", "c:\Projects\AssetManager\CSVUtilities", "c:\Projects\AssetManager\IPUtilities", "c:\Projects\AssetManager\GeoIP")

# release from branch svn://bgsvn01:3694/Branches/20230103, Revision 6918
#$Global:svnRepoPath = @("svn://bgsvn01:3694/Branches/20230103","svn://bgsvn01:3695/trunk/shared/TasksLibrary", "svn://bgsvn01:3695/trunk/shared/CSVUtilities","svn://bgsvn01:3695/trunk/shared/IPUtilities","svn://bgsvn01:3695/trunk/shared/GeoIP")
#$Global:branchFolder = @("c:\Projects\AssetManagerFromPrelife\", "c:\Projects\AssetManagerFromPrelife\TasksLibrary\", "c:\Projects\AssetManagerFromPrelife\CSVUtilities", "c:\Projects\AssetManagerFromPrelife\IPUtilities", "c:\Projects\AssetManagerFromPrelife\GeoIP")

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\CommonVariables.ps1"
