#
# 20181024 Miro : Publich "Trunk" svn branch to test-media.usdirectory.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

# pictures copy variables
$fromPictures = $branchFolder[0]+"\Shooger\UsdMediaSite\"
$toPictures =  "\\$Server\c$\projects\Sites\test-media.usdirectory.com\" 

TransferMediaSitePictures $fromPictures $toPictures

CleanupVariables
