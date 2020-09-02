@istest
Public class GE_PRM_Batch_Update_ComAccs_Test {
/*        
    @testsetup
    static void createData(){
                 
        account Racc = new account();
        Racc.name = 'Test1';
        Racc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        Racc.ShippingCountry = 'India';
        Racc.Account_Tier_GEOG__c = 'Country';
        Racc.Type = 'Direct Customer';
        Racc.Classification__c = 'Strategic';
        insert Racc;
        
        
        account Cacc = new account();
        Cacc.name = 'Test2';
        Cacc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        Cacc.ShippingCountry = 'India';
        Cacc.Account_Tier_GEOG__c = 'Global';
        Cacc.Oil_Gas_Parent_Account__c = Racc.Id; 
        insert Cacc;
        
        Account accLE = new account();
        accLE.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        accLE.name = 'Test Account LE';
        accLE.Account_Tier_GEOG__c = 'LE';
        accLE.Oil_Gas_Parent_Account__c = Racc.Id; 
        accLE.Country_GEOG__c = 'INDIA';
        accLE.Classification__c= 'Strategic';
        accLE.Type = 'Competitor';
        accLE.ShippingCountry = 'India';
        accLE.Account_Status__c = 'CC Approved';
        insert accLE;
                
        GE_PRM_Channel_Appointment__c ca = New GE_PRM_Channel_Appointment__c();
        ca.GE_PRM_Appointment_Type__c = 'New';
        ca.GE_PRM_Tier_2_P_L__c = 'DTS';
        ca.GE_PRM_Account_Name__c = Cacc.Id;
        Insert ca;
        
  
        
        Apttus__APTS_Agreement__c ag = new Apttus__APTS_Agreement__c();       
        ag.Name = 'Test Agreement';
        ag.Apttus__Account__c = Cacc.Id;
        ag.GE_PRM_Channel_Appointment_ID__c = ca.Id ;
        //ag.CurrencyIsoCode = 'AED - UAE Dirham';

        insert ag;

        list<Contract> lstCon = new list<Contract>();
        Contract c = new Contract();       
        c.Name = 'Test Con';
        c.AccountId = Cacc.Id;
        c.GE_PRM_Channel_Appointment_ID__c = ca.Id ;
        c.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
        c.GE_HQ_Buss_Tier1__c = 'PII';
        c.GE_HQ_Buss_Tier2__c = 'Reuter Stokes';
        c.GE_OG_Legal_Entity__c = 'ALGESCO SPA';
        c.StartDate =  Date.Today();
        c.GE_OG_Contract_End_Date__c = Date.Today() +8 ;
        c.Status  =  'Generate Draft'; 
        c.GE_OG_FA_Type__c = 'Discount';
        lstCon.add(c);

        Contract c1 = new Contract();       
        c1.Name = 'Test Con';
        c1.AccountId = Cacc.Id;
        c1.GE_PRM_Channel_Appointment_ID__c = ca.Id ;
        c1.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
        c1.GE_HQ_Buss_Tier1__c = 'PII';
        c1.GE_HQ_Buss_Tier2__c = 'Reuter Stokes';
        c1.GE_OG_Legal_Entity__c = 'ALGESCO SPA';
        c1.StartDate =  Date.Today();
        c1.GE_OG_Contract_End_Date__c = Date.Today() +8 ;
        c1.Status  =  'Under NR/T'; 
        c1.GE_OG_FA_Type__c = 'Discount';
        lstCon.add(c1);

        Contract c2 = new Contract();       
        c2.Name = 'Test Con';
        c2.AccountId = accLE.Id;
        c2.RecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
        c2.GE_PRM_Channel_Appointment_ID__c = ca.Id ;
        c2.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
        c2.GE_HQ_Buss_Tier1__c = 'PII';
        c2.GE_HQ_Buss_Tier2__c = 'Reuter Stokes';
        c2.GE_OG_Legal_Entity__c = 'ALGESCO SPA';
        c2.StartDate =  Date.Today();
        c2.GE_OG_Contract_End_Date__c = Date.Today() +8 ;
        c2.Status  =  'Under NR/T'; 
        c2.GE_OG_FA_Type__c = 'Discount';
        lstCon.add(c2);
         
        insert lstCon;
    }
  
    public static testMethod void GE_PRM_Batch_Update_CAgr_test1()
    {
        Test.StartTest();   

        GE_PRM_Batch_AccType_Scheduler schedulerApex = new GE_PRM_Batch_AccType_Scheduler();
        SchedulableContext SC ;
        schedulerApex.execute(sc);

        //GE_PRM_Batch_Update_ComAccs_Scheduler obj = new GE_PRM_Batch_Update_ComAccs_Scheduler ();
        //obj.execute(SC );

        //GE_PRM_Batch_Update_ComAccs_Contract obj1 = new GE_PRM_Batch_Update_ComAccs_Contract();
        //database.executebatch(obj1 );

        Id batchId = Database.executeBatch(new GE_PRM_Batch_AccountType_Update(), 200);
        
        Account accLE = new account();
        accLE.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        accLE.name = 'Test Account LE';
        accLE.Account_Tier_GEOG__c = 'LE';
        accLE.Country_GEOG__c = 'INDIA';
        accLE.Classification__c= 'Strategic';
        accLE.Type = 'Competitor';
        accLE.ShippingCountry = 'India';
        accLE.Account_Status__c = 'CC Approved';
        insert accLE;
        
        List<sObject> lstObj = new List<sObject>();
        Contract c3 = new Contract();       
        c3.Name = 'Test Con';
        c3.RecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Addendum Frame Agreement').getRecordTypeId();
        c3.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
        c3.GE_HQ_Buss_Tier1__c = 'PII';
        c3.GE_HQ_Buss_Tier2__c = 'Reuter Stokes';
        c3.GE_OG_Legal_Entity__c = 'ALGESCO SPA';
        c3.StartDate =  Date.Today();
        c3.GE_OG_Contract_End_Date__c = Date.Today() +8 ;
        c3.Status  =  'Executed'; 
        c3.GE_OG_FA_Type__c = 'Discount';
        c3.GE_PRM_Commercial_Account__c = null;
        lstObj.add(c3);
        
        Id batchId2 = Database.executeBatch(new GE_Account_Batch_Update_Contract(), 200);
        GE_Account_Batch_Update_Contract btch = new GE_Account_Batch_Update_Contract();
        try{
            btch.execute(null, lstObj);      
        }catch(Exception e){}
        
        Test.StopTest();     
    
    }

    
*/
}