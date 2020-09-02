@isTest(seealldata=true)
public class GE_OG_NewTech_UsrNotFoundExtTest {

    static testmethod void testNotFound(){

        System.Test.startTest();
        
         SVMXC__Service_Group__c team = new SVMXC__Service_Group__c(
           Name = 'test'
        );
        
        insert team;
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
           SVMXC__Street__c = 'test Home street',
           SVMXC__City__c = 'test home city',
           SVMXC__State__c = 'test home state',
           SVMXC__Country__c = 'United States',
           SVMXC__Zip__c = 'test home zip',
           SVMXC__Longitude__c = 1.1,
           SVMXC__Latitude__c = 1.2,
           SVMXC__Service_Group__c = team.Id,
           GE_SM_HQ_SSO_ID__c = '025511880',
           GE_SM_HQ_Regional_Manager__c = 'test Manager'
        );
        
        insert tech;
        
        ApexPages.StandardController sc1 = new ApexPages.StandardController (tech);
        PageReference mypage = Page.GE_OG_NewTech_UsrNotFound;
        Test.setCurrentPage(mypage);
        // put a valid technican ID into URL
        System.currentPageReference().getParameters().put('techId', tech.id);
        GE_OG_NewTech_UsrNotFoundExt nce1 = new GE_OG_NewTech_UsrNotFoundExt(sc1);
        nce1.submit();
        
        Profile prof = [select Id from Profile where Name='System Administrator'];
        ApexPages.StandardController sc2 = new ApexPages.StandardController (tech);
        PageReference mypage2 = Page.GE_OG_NewTech_UsrNotFound;
        Test.setCurrentPage(mypage2);
        // non technician related ID/Objedt given in the URL
        System.currentPageReference().getParameters().put('techId', prof.id);
        GE_OG_NewTech_UsrNotFoundExt nce2 = new GE_OG_NewTech_UsrNotFoundExt(sc2);
        nce2.submit();
        
        
        System.Test.stopTest();
    }
}