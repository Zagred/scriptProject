# 20190704 Miro : Publich "Trunk" svn branch to test.shooger.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "c:\Published\Site\Safeco.Test"
$Global:remoteFilesPath =  "C:\projects\Sites\test-safeco.shooger.com\" 
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerNet\ShoogerNet.csproj"
$Global:transferZipFileName = "Safeco.7z"

PublishSite
