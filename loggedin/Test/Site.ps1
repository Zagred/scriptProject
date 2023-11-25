# 20181022 Miro : Publich "Trunk" svn branch to test.loggedin.io
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "c:\Published\Site\Loggedin.Test"
$Global:remoteFilesPath = "C:\projects\Sites\test.loggedin.io\" 
$Global:UpdateCss = $Global:localFilesPath + "\Web.config"
$Global:transferZipFileName = "Loggedin.7z"

$Global:UpdateCss = $Global:localFilesPath + "\Web.config"

PublishSite
