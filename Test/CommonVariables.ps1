$Global:svnRepoPath = @("svn://bgsvn01:3694/AssetManager","svn://bgsvn01:3695/trunk/shared/TasksLibrary","svn://bgsvn01:3695/trunk/shared/CSVUtilities","svn://bgsvn01:3695/trunk/shared/IPUtilities","svn://bgsvn01:3695/trunk/shared/GeoIP")
$Global:branchFolder = @("D:\Projects\AssetManager", "D:\Projects\AssetManager\TasksLibrary", "D:\Projects\AssetManager\CSVUtilities", "D:\Projects\AssetManager\IPUtilities", "D:\Projects\AssetManager\GeoIP")

$Global:configuration = "Test"
# all web project have such profile, that's why it is in common file
$Global:projectPublishProfile = "Test.pubxml"

$Global:Server = "bgwebtest01.corp.shooger.com"
$Global:ServiceName = "Background Tasks service (AssetManager)"

# because that is test environment we do not need backups
$Global:makeBackup = $false
$Global:BackupFile = "empty"
$Global:BackupPath = "empty"

$rootPath  = (Get-Item $PSScriptRoot).Parent.Parent.FullName
. "$rootPath\Common\CommonVariables.ps1"

$Global:solutionBuildFile = $branchFolder[0] + "\AssetManager.sln"  
$Global:SiteName = "";
