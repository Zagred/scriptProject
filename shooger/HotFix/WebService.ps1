#
# Publich "branches/hotfixshooger" svn branch to hotfix.shoogerservices.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\Published\Services\Shooger.HotFix"
$Global:remoteFilesPath = "D:\Projects\Shooger\hotfix.shoogerservices.com\"
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\www.shoogerservices.com\www.shoogerservices.com.csproj"
$Global:transferZipFileName = "ShoogerServices.7z"

$Global:SiteName = "hotfix-services.shooger.com";
$Global:RestartSiteOnTransfer = $true

PublishSite