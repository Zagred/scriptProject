# 20181030 Miro 
# 20200512 Miro : Restructure/simplify variables and includes
#
$Global:DeleteTransferredArchive = $false
#$Global:makeBackup = $true

$Global:configuration = "Shooger.Release"
$Global:projectPublishProfile = "Shooger.Release.pubxml"

$Global:solutionBuildFile = $branchFolder[0] + "\Shooger\Shooger2017.sln"  

$Global:Server = "usdn2.corp.shooger.com"

$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\ShoogerCommonFile.ps1"





