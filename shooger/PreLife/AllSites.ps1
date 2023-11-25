#
# AllSites.ps1
# Publich "bracnes/prelife" svn branch to prelife.shooger.com
# Publich "bracnes/prelife" svn branch to prelife.media.shooger.com
# Publich "bracnes/prelife" svn branch to prelife-services.shooger.com
#
$LocalScriptPath  = (Get-Item $PSScriptRoot).FullName
. "$LocalScriptPath\Site.ps1"
. "$LocalScriptPath\MediaSite.ps1"
. "$LocalScriptPath\WebService.ps1"

