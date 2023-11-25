# Publish "branches/prelife" svn branch to https://prelife.shooger.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "c:\Published\Site\Safeco.PreLife"
$Global:remoteFilesPath = "C:\projects\sites\prelife-safeco.shooger.com\" 
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerNet\ShoogerNet.csproj"
$Global:transferZipFileName = "PreLifeSafeco.7z"
 
$Global:UpdateCss = $Global:localFilesPath + "\Web.config"

PublishSite
