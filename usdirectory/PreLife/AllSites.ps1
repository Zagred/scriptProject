#
# AllSites.ps1
# Publich "bracnes/prelife" svn branch to prelife.usdirecttory.com
# Publich "bracnes/prelife" svn branch to prelife.media.usdirecttory.com
# Publich "bracnes/prelife" svn branch to prelife-services.usdirecttory.com
#
$LocalScriptPath  = (Get-Item $PSScriptRoot).FullName
. "$LocalScriptPath\Site.ps1"
. "$LocalScriptPath\MediaSite.ps1"
. "$LocalScriptPath\WebService.ps1"


