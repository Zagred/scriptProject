#
# 20200512 Miro : Restructure common variables
# Include after include particular configucation common file
#
$rootPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$rootPath\Common\CommonVariables.ps1"
. "$rootPath\Common\CommonFunctions.ps1"
. "$rootPath\Common\RemoteOperations.ps1"

$Global:solutionBuildFile = $branchFolder[0] + "\HandsdownStudios.sln"  
$Global:platform = "Any CPU"
$Global:buildCommandParams = "/p:Configuration=$configuration;Platform=`"$platform`""
$Global:projectBuildFile = $branchFolder[0] + "\Web\Web.csproj" 


