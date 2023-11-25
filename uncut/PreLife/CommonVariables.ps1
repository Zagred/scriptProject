#
# 20200512 Miro : Restructure/simplify variables and includes
#
$Global:configuration = "Uncut.Prelife"
$Global:projectPublishProfile = "Uncut.Prelife.pubxml"

$Global:svnRepoPath = @("svn://bgsvn01:3694/Branches/20230103","svn://bgsvn01:3695/trunk/shared/TasksLibrary","svn://bgsvn01:3695/trunk/shared/CSVUtilities","svn://bgsvn01:3695/trunk/shared/IPUtilities","svn://bgsvn01:3695/trunk/shared/GeoIP")
$Global:branchFolder = @("c:\Projects\AssetManager\Prelife", "c:\Projects\AssetManager\Prelife\TasksLibrary", "c:\Projects\AssetManager\Prelife\CSVUtilities", "c:\Projects\AssetManager\Prelife\IPUtilities", "c:\Projects\AssetManager\Prelife\GeoIP")

$Global:Server = "bgwebtest02.corp.shooger.com"
$Global:RestartSiteOnTransfer = $true
$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\UncutCommon.ps1"
