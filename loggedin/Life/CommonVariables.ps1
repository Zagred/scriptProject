# 20181030 Miro : Common variables for Production (Life) no matter of branch
# 20200512 Miro : Restructure/simplify variables and includes
#
$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\LoggedInCommon.ps1"

$Global:configuration = "Loggedin.Release"
$Global:projectPublishProfile = "Loggedin.Release.pubxml"
 
$Global:Server = "usdn2.corp.shooger.com"





