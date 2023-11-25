# 20181030 Miro 
# 20200513 Miro : Restructure/simplify variables and includes
#
$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\ReefrCommon.ps1"

$Global:configuration = "Reefr.Release"
$Global:projectPublishProfile = "Reefr.Release.pubxml"

$Global:solutionBuildFile = $branchFolder[0] + "\Shooger\Shooger2017.sln"  

$Global:Server = "usdn2.corp.shooger.com"





