#
# Everything.ps1
#

$LocalScriptPath  = (Get-Item $PSScriptRoot).FullName
. "$LocalScriptPath\Site.ps1"
. "$LocalScriptPath\MediaSite.ps1"
. "$LocalScriptPath\Pictures.ps1"
. "$LocalScriptPath\WebService.ps1"
. "$LocalScriptPath\WindowsService.ps1"
. "$LocalScriptPath\ScheduledTasks.ps1"
