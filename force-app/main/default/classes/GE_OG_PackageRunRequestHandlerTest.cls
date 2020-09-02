@isTest
public class GE_OG_PackageRunRequestHandlerTest {
    
    static testMethod void testGE_OG_PackageRunRequestHandler(){
        
        // Create test data of an installed managed package
        Package__c SMax = new Package__c();
        SMax.Name='ServiceMax';
        SMax.Package_Id__c='050A00000009BzEIAU';
        SMax.UserFieldApiName__c='GE_Is_ServiceMax_User__c';
        
        Insert SMax;
        
        // Create Package Run records
        Package_Run_Request__c PR1 = new Package_Run_Request__c();
        Package_Run_Request__c PR2 = new Package_Run_Request__c();
        
        List<Package_Run_Request__c> PRList = new List<Package_Run_Request__c>();
        PRList.add(PR1);
        PRList.add(PR2);
        
        insert PRList;
        
		Test.startTest();
                
        // run the code in the handler
        GE_OG_PackageRunRequestHandler.runPackageLicenseBatchJob(PRList);
        
        //PR1 = new Package_Run_Request__c();
        //PR2 = new Package_Run_Request__c();
        
        //List<Package_Run_Request__c> PRList2 = new List<Package_Run_Request__c>();
        //PRList2.add(PR1);
        //PRList2.add(PR2);
        
        //insert PRList2;
        
        //GE_OG_PackageRunRequestHandler.runFlaggingMapping(true);
        
        Test.stopTest();
        
    }
    
}