# Publish "branches/prelife" svn branch to https://prelife.shooger.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "c:\Published\Site\Reefr.PreLife"
$Global:remoteFilesPath = "C:\projects\sites\prelife-reefr.shooger.com\" 
$Global:transferZipFileName = "Reefr.7z"

$Global:UpdateCss = $Global:localFilesPath + "\Web.config"

PublishSite
