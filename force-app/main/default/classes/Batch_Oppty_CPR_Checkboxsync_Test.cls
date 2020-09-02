@isTest
public class Batch_Oppty_CPR_Checkboxsync_Test {
    @istest
    public static void opptyCPRbatchmethod(){
         Test.startTest();
        Account acc = AccountTestDataFactory.createRelationshipAccount('Test Acc 1');
        for(Integer i=0; i< 1; i++){
          //  CommonTestDataFactory_GE_OG.createOppty('New Oppty'+i,acc.Id);
      
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
         
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting1();
        
        opportunity opp = new opportunity();
        opp.name= 'Test fct'+i;
        opp.stageName = 'Prospecting';
        opp.has_opportunitycontactrole_ge_og__c = True;
        opp.region_ge_og__c = 'Test Region';
        opp.Risk_Region_ge_og__c = 'Test Region';
        opp.closedate = system.today().addDays(30);
        opp.accountId = acc.ID;
        //Changed the below from Measurement & Control to Digital Solutions - kiru
        opp.tier_2_ge_og__c ='Digital Solutions';
        opp.tier_3_ge_og__c ='Bently Nevada';
        //opp.GE_Estimated_Amount__c = 1000.00;
        opp.amount_ge_og__c =100.00;
        opp.install_country_ge_og__c= 'India';  
        opp.has_commercial_primary_resource_ge_og__c = true;
        insert opp;
        }
        
        
        
       

           Batch_Oppty_CPR_Checkboxsync obj = new Batch_Oppty_CPR_Checkboxsync();
            DataBase.executeBatch(obj);
          
           
        Test.stopTest();
    }

}