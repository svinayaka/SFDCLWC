@isTest
public class CampaignMemberDetailAsPDF_Test
{
    public static testMethod void testCMRtypeLead()
    {
        Campaign testTheme = CommonTestDataFactory_GE_OG.createThemeCampaign('Test theme');
        Campaign tesProgram = CommonTestDataFactory_GE_OG.createProgramCampaign('Test Program', testTheme.Id);
        Campaign testCampaign = CommonTestDataFactory_GE_OG.createCampaign('Test Camp', tesProgram.Id);
        
        Lead testLead = CommonTestDataFactory_GE_OG.createLead('firstname','lastname');
        
        CampaignMember testCMR = new CampaignMember();
        testCMR.CampaignId = testCampaign.Id;
        testCMR.LeadId = testLead.Id;
        testCMR.Status = 'Lead Prospecting';
        insert testCMR;
        
        
        PageReference pg = Page.campaignMemberRecordPDF;
        Test.setCurrentPage(pg);
         ApexPages.currentPage().getParameters().put('ID', testCMR.Id);
         ApexPages.currentPage().getParameters().put('Type','Lead');
         
        ApexPages.StandardController stc = new ApexPages.StandardController(testCMR); 
        CampaignMemberDetailAsPDF controller = new CampaignMemberDetailAsPDF(stc);
        
        
        
    }
    
    public static testMethod void testCMRtypeContact()
    {
        Campaign testTheme = CommonTestDataFactory_GE_OG.createThemeCampaign('Test theme');
        Campaign tesProgram = CommonTestDataFactory_GE_OG.createProgramCampaign('Test Program', testTheme.Id);
        Campaign testCampaign = CommonTestDataFactory_GE_OG.createCampaign('Test Camp', tesProgram.Id);
        
        
        Account acc = CommonTestDataFactory_GE_OG.createAccount('Test Account');
        Contact con = new Contact();
        con.Lastname = 'Test';
        con.Firstname = 'BHGE';
        con.AccountId = acc.Id;
        con.Email = 'abc@def.com';
        con.GE_OG_Contact_Audience__c = 'Sales/ITO';
        insert con;
        
        CampaignMember testCMR = new CampaignMember();
        testCMR.CampaignId = testCampaign.Id;
        testCMR.ContactId = con.Id;
        testCMR.Status = 'Lead Prospecting';
        insert testCMR;
        
        PageReference pg = Page.campaignMemberRecordPDF;
        Test.setCurrentPage(pg);
         ApexPages.currentPage().getParameters().put('ID', testCMR.Id);
         ApexPages.currentPage().getParameters().put('Type','Contact');
         
        ApexPages.StandardController stc = new ApexPages.StandardController(testCMR); 
        CampaignMemberDetailAsPDF controller = new CampaignMemberDetailAsPDF(stc);
        
    }
}