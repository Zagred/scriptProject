#
# 20200512 Miro : Restructure common variables
# Include after include particular configucation common file
#
$Global:username = "s_transfer_user"

$rootPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$rootPath\Common\CommonVariables.ps1"
. "$rootPath\Common\CommonFunctions.ps1"
. "$rootPath\Common\RemoteOperations.ps1"

$Global:solutionBuildFile = $branchFolder[0] + "\AssetManager.sln"  
$Global:platform = "Any CPU"
$Global:buildCommandParams = "/p:Configuration=$configuration;Platform=`"$platform`""

$Global:ServiceName = "Background Tasks service (AssetManager)"


