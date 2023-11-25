# 20181030 Miro 
# 20200512 Miro : Restructure/simplify variables and includes
#
$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\SafecoCommon.ps1"

$Global:configuration = "Safeco.Release"
$Global:projectPublishProfile = "Safeco.Release.pubxml"

$Global:solutionBuildFile = $branchFolder[0] + "\Shooger\Shooger2017.sln"  

$Global:Server = "usdn2.corp.shooger.com"





