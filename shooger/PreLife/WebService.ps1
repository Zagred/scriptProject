# Publich "branches/prelife" svn branch to https://prelife-services.shooger.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\Published\Services\Shooger.PreLife"
$Global:remoteFilesPath = "C:\projects\sites\prelife-services.shooger.com\"
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\www.shoogerservices.com\www.shoogerservices.com.csproj"
$Global:transferZipFileName = "PreLifeShoogerServices.7z"

$Global:SiteName = "prelife-services.shooger.com";
$Global:RestartSiteOnTransfer = $true

PublishSite
