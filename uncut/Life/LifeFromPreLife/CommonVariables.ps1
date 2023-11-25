# 20200730 Miro : Restructure/simplify variables and includes

$Global:svnRepoPath = @("svn://bgsvn01:3694/Branches/20230103","svn://bgsvn01:3695/trunk/shared/TasksLibrary","svn://bgsvn01:3695/trunk/shared/CSVUtilities","svn://bgsvn01:3695/trunk/shared/IPUtilities","svn://bgsvn01:3695/trunk/shared/GeoIP")
$Global:branchFolder = @("c:\Projects\AssetManager\Prelife", "c:\Projects\AssetManager\Prelife\TasksLibrary", "c:\Projects\AssetManager\Prelife\CSVUtilities", "c:\Projects\AssetManager\Prelife\IPUtilities", "c:\Projects\AssetManager\Prelife\GeoIP")

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\CommonVariables.ps1"


