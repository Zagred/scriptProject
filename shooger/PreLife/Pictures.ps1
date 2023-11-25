#
#
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$fromPictures = $branchFolder[0]+"\Shooger\ShoogerMediaAPI\"
$toPictures =  "\\$Server\c$\projects\Sites\prelife-media.shooger.com\" 

TransferMediaSitePictures $fromPictures $toPictures

CleanupVariables
