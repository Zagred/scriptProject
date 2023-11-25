#
# 20200512 Miro : Restructure common variables
# Include after include particular configucation common file
#
$rootPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$rootPath\Common\CommonVariables.ps1"
. "$rootPath\Common\CommonFunctions.ps1"
. "$rootPath\Common\RemoteOperations.ps1"

$Global:makeBackup = $true
$Global:solutionBuildFile = $branchFolder[0] + "\Shooger\Shooger2017.sln"  
$Global:platform = "Any CPU"
$Global:buildCommandParams = "/p:Configuration=$configuration;Platform=`"$platform`""
$Global:MediaFolders = @("assets", "Content", "Emails", "fonts", "css", "css2", "css3", "css4", "images", "imgs", "imgs3", "imgs4", "Directory", "Agency Model" )

$Global:ServiceName = "Background Tasks service (Usdirectory)"


