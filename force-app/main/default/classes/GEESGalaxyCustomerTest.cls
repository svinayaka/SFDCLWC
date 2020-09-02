@isTest
private class GEESGalaxyCustomerTest {

    static testMethod void testCustomer(){
        try{
        Test.startTest();   
        GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
        GE_HQ_Region__c rgn = new GE_HQ_Region__c();
        rgn.name = 'India';
        insert rgn;
        
        GE_HQ_Region__c rgn1 = new GE_HQ_Region__c();
        rgn1.name = 'USA';
        insert rgn1;
        
        Set<id> regionid= new Set<id>{rgn.id, rgn1.id};

        
         Set<Id> userid=new Set<Id> {userinfo.getUserid()};
        
        Account objCustomer = new Account();
        objCustomer.GE_HQ_DUNS_Number__c='SAIx91858';
        objCustomer.GE_HQ_Request_Status__c = 'CMF Approved';
        objCustomer.GE_ES_Primary_Industry__c='CEMENT';
        objCustomer.Name='Sai Test Acc 1';
        objCustomer.GE_HQ_Region_Tier1__c = rgn.id;
        insert objCustomer;
        
        objCustomer.GE_HQ_DUNS_Number__c='SAIx91859';
        objCustomer.GE_ES_Primary_Industry__c='Drilling';
        objCustomer.GE_HQ_Region_Tier1__c = rgn1.id;
        update objCustomer;
        
        GE_HQ_P_L_Specific_Info__c pl = new GE_HQ_P_L_Specific_Info__c();
        pl.GE_HQ_Account__c = objCustomer.id;
        pl.GE_HQ_Buss_Tier__c = 'Power & Water (P&W)';
        pl.GE_HQ_Buss_Tier1__c = 'Thermal';
        pl.GE_HQ_Buss_Tier2__c = 'Environmental Services';
        pl.GE_ES_Env_Prim_Ind__c = 'ALUMINUM';
        insert pl;
        
        Set<id> accid= new Set<id>{objCustomer.id};
        
        IntegrationExecution int_var = new IntegrationExecution('PW');
        int_var.IsOrgName=false;
        

        GE_ES_CustomerGalaxyIntegrationWrapper.newAccountRequest(accid, userid , regionid);
        
        int_var.IsOrgName=true;     
        
        GE_ES_CustomerGalaxyIntegrationWrapper.newAccountRequest(accid, userid , regionid);
        Test.stopTest();
        }
        catch(Exception e){}
    }
    }