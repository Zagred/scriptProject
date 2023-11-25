# 20181030 Miro 
# 20200512 Miro : Restructure/simplify variables and includes
#
$Global:DeleteTransferredArchive = $false
#$Global:makeBackup = $true

$Global:configuration = "USD.Release"
$Global:projectPublishProfile = "USD.Release.pubxml"

$Global:solutionBuildFile = $branchFolder[0] + "\Shooger\Shooger2017.sln"  

$Global:ServiceName = "Background Tasks service (Usdirectory)"

$Global:Server = "usdn2.corp.shooger.com"

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\USDCommon.ps1"


