#
# 20200730 Miro : Restructure/simplify variables and includes
#
$Global:configuration = "Uncut.Release"
$Global:projectPublishProfile = "Uncut.Release.pubxml"

$Global:solutionBuildFile = $branchFolder[0] + "\AssetManager.sln"  

$Global:makeBackup = $true

$Global:Server = "USWEBUNCUTPRD01.uncut.local"

$Global:UseSession = $false

$Global:SiteName = "www.uncut.cloud"

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\UncutCommon.ps1"


