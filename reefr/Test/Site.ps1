# 20190704 Miro : Publich "Trunk" svn branch to test.shooger.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "c:\Published\Site\Reefr.Test"
$Global:remoteFilesPath =  "C:\projects\Sites\test-reefr.shooger.com\" 
$Global:transferZipFileName = "Reefr.7z"
 
$Global:UpdateCss = $Global:localFilesPath + "\Web.config"

PublishSite
