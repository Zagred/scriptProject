# 20220308 Miro : Copied from trunk script

$Global:svnRepoPath = @("svn://bgsvn01:3694/Branches/Stage","svn://bgsvn01:3695/trunk/shared/TasksLibrary", "svn://bgsvn01:3695/trunk/shared/CSVUtilities","svn://bgsvn01:3695/trunk/shared/IPUtilities","svn://bgsvn01:3695/trunk/shared/GeoIP")
$Global:branchFolder = @("c:\Projects\AssetManager-Stage\", "c:\Projects\AssetManager-Stage\TasksLibrary\", "c:\Projects\AssetManager-Stage\CSVUtilities", "c:\Projects\AssetManager-Stage\IPUtilities", "c:\Projects\AssetManager-Stage\GeoIP")

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\CommonVariables.ps1"
