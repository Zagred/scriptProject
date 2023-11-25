$Global:Folders = @("\\192.168.168.26\c$\Projects\Sites\shooger.com\", "\\192.168.168.26\c$\Projects\Sites\usdirectory.com\", "\\192.168.168.28\c$\Projects\Sites\shooger.com\", "\\192.168.168.28\c$\Projects\Sites\usdirectory.com\", "\\192.168.168.86\c$\Projects\Sites\usdirectory.com\", "\\192.168.168.87\c$\Projects\Sites\usdirectory.com\" )

$Global:Files = @("TipsLocationM.aspx", "BecomeAdvertiserOld.aspx", "ContactUs1.aspx","ContactUsM.aspx", "ContactUsM1.aspx", "Deals.aspx","DealsOld.aspx", "Default2.aspx")
$Global:Files += @("TipsLocation.aspx", "EmailSendTest.aspx", "FAQAdvertiser.aspx", "FAQConsumer.aspx", "FindOld.aspx", "Finds.aspx")
$Global:Files += @("Error404M.aspx", "GrowYourBusiness.aspx", "HowItWorksM.aspx", "HTMLFormatingTestPage.aspx", "Index.aspx", "Index2.aspx", "IndexM.aspx", "Materials.aspx", "MediaTest.aspx", "MobileAD.aspx", "MyBusinesses.aspx", "MyPeopleOld.aspx", "NewFind.aspx", "NewSMTPServerTest.aspx", "Offers.aspx", "OffersOld.aspx", "PricingPlans.aspx", "Promo.aspx", "PromoM.aspx", "PromoOld.aspx", "PromoPreview.aspx", "PromoPrint.aspx", "SavedDeals.aspx", "SavedFinds.aspx", "SearchTracker.aspx", "ShoogerConnectPricing.aspx", "ShoogerMerchants2.aspx", "ShoogerMerchantsM.aspx", "ShoogerOfferM.aspx", "ShoogerOfferM_Old.aspx", "ShoogerOfferPreview.aspx", "shooger_chat.aspx", "SMSSendTestPage.aspx", "TermsM.aspx", "TermsOfService.aspx", "Test.aspx", "test2.aspx", "TestDetection.aspx")
$Global:Files += "Error404.aspx"
$Global:Files += "OffersM.aspx"
$Global:Files += "PrivacyM.aspx"
$Global:Files += "Privacy.aspx"
$Global:Files += "About.aspx"
$Global:Files += "AboutM.aspx"
$Global:Files += "lps\getshooger_vlp1.aspx"
$Global:Files += "lps\getshooger_vlp1M.aspx"
$Global:Files += "AddTip.aspx"
$Global:Files += "AddTipM.aspx"
$Global:Files += "GeneralError.aspx"
$Global:Files += "GeneralErrorM.aspx"
$Global:Files += "FindM.aspx"
$Global:Files += "Find.aspx"
$Global:Files += "DownloadBlackberryApp.aspx"
$Global:Files += "Places.aspx"
$Global:Files += "PlacesM.aspx"
$Global:Files += "ShoogerConnectWhyUs.aspx"
$Global:Files += "ShoogerMerchants.aspx"
$Global:Files += "Tips.aspx"
$Global:Files += "TipsM.aspx"
$Global:Files += "lps\shoogerfreedemo.aspx"
$Global:Files += "Packages.aspx"
$Global:Files += "PackagesM.aspx"
$Global:Files += "server.htm"
$Global:Files += "Default - Copy.aspx"
$Global:Files += "delete-old-files.bat"
$Global:Files += "UsersService.asmx"
$Global:Files += "Web.PreLifeTestDirectorySites.config"
$Global:Files += "Web.testdirectorysites1.config"
$Global:Files += "Web.testdirectorysites2.config"


Foreach($folder in $Folders)
{
	Foreach($file in $Files)
	{
		$FileName = "$folder$file"
		if (Test-Path $FileName) 
		{
			Write-Host "delete $FileName" -ForegroundColor Green
			Set-ItemProperty $FileName -name IsReadOnly -value $false
			Remove-item $FileName
		} 
	}
}
	 

