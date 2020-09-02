@IsTest

Public class PostChatteronAccountTest {


    
   static testMethod void testMethod1(){
   test.starttest();
            
           
        account a1 = new account();
        a1.name='test';
        a1.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        a1.Classification__c= 'Key Account' ;
        a1.type = 'Direct Customer';
        a1.Account_Tier_GEOG__c  = 'Regional';
        insert a1;
              
        account a2 = new account();
        a2.name='test';
        a2.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        a2.Classification__c= 'Key Account' ;
        a2.type = 'Direct Customer';
        a2.Account_Tier_GEOG__c  = 'Country';
        a2.parentid = a1.id;
        insert a2;
        
        task t=new task();
        t.Status='New';
        t.subject='test';
        t.RecordtypeID = Util_GE_OG.getRecordTypeDetails('Task','Deal Machine Task').getRecordTypeId();
        t.whatid=a1.id;
        t.type = 'Customer Meeting';
        t.Activitydate = Date.newInstance(2018, 12, 9);
        insert t;   
        
        task t3=new task();
        t3.Status='New';
        t3.subject='test';
        t3.RecordtypeID = Util_GE_OG.getRecordTypeDetails('Task','Deal Machine Task').getRecordTypeId();
        t3.whatid=a2.id;
        t3.type = 'Customer Meeting';
        t3.Activitydate = Date.newInstance(2018, 12, 9);
        insert t3;    
        
        PostChatteronAccount c = new PostChatteronAccount();  
   
   
   
   
   test.stoptest();
            

    }    
         
    
    
    static testMethod void testMethod2(){
   test.starttest();
   
        account acc = new account();
        acc.name = 'Test Acc';
        acc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc.ShippingCountry = 'India';
        acc.Account_Tier_GEOG__c = 'Global';
        acc.Region_GEOG__c = 'India';
        acc.Type = 'Direct Customer';
        acc.Classification__c = 'Strategic';
        insert acc;
               
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting1();
        
                     
        //Creating an Opportunity
        opportunity opp = new opportunity();
        opp.name= 'Test Oppty';
        opp.stageName = 'Prospecting';
        opp.has_opportunitycontactrole_ge_og__c = True;
        opp.region_ge_og__c = 'Test Region';
        opp.Risk_Region_ge_og__c = 'Test Region';
        opp.closedate = system.today().addDays(30);
        opp.accountId = acc.Id;
        opp.tier_2_ge_og__c ='Digital Solutions';
        opp.tier_3_ge_og__c ='Bently Nevada';
        opp.amount_ge_og__c =60000.00;
        opp.amount = 75000.00;
        opp.install_country_ge_og__c= 'India'; 
        insert opp;
              
               System.debug('akp12345'+ opp.Amount_Std_USD__c + opp.Amount_USD_ge_og__c +opp.amount+opp.amount_ge_og__c);    
               
        task t2=new task();
        t2.Status='New';
        t2.subject='test';
        t2.RecordtypeID = Util_GE_OG.getRecordTypeDetails('Task','Deal Machine Task').getRecordTypeId();
        t2.whatid=opp.id;
        t2.type = 'Customer Meeting';
        t2.Activitydate = Date.newInstance(2018, 12, 9);
        insert t2; 
                     
        PostChatteronAccount c = new PostChatteronAccount();  
   
   
   
   
   test.stoptest();

    }    
    
    
       
    
    
   static testMethod void testMethod3(){
   test.starttest();
            
           
        account a1 = new account();
        a1.name='test';
        a1.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        a1.Classification__c= 'Key Account' ;
        a1.type = 'Direct Customer';
        a1.Account_Tier_GEOG__c  = 'Regional';
        insert a1;
              
        account a2 = new account();
        a2.name='test';
        a2.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        a2.Classification__c= 'Key Account' ;
        a2.type = 'Direct Customer';
        a2.Account_Tier_GEOG__c  = 'Country';
        a2.parentid = a1.id;
        insert a2;
                
          
        Asset a = new Asset();
        a.name = 'test';
        a.accountid = a2.id;
        insert a;
        
        Asset at = new Asset();
        at.name = 'test';
        at.accountid = a1.id;
        insert at;
        
        Project_ge_og__c p = new Project_ge_og__c();
        p.name ='test';
        p.project_account_ge_og__c = a2.id;
        insert p;
        
        Project_ge_og__c p1 = new Project_ge_og__c();
        p1.name ='test';
        p1.project_account_ge_og__c = a1.id;
        insert p1;
        
                
        task t2=new task();
        t2.Status='New';
        t2.subject='test';
        t2.RecordtypeID = Util_GE_OG.getRecordTypeDetails('Task','Deal Machine Task').getRecordTypeId();
        t2.whatid=a.id;
        t2.type = 'Customer Meeting';
        t2.Activitydate = Date.newInstance(2018, 12, 9);
        insert t2; 
               
        task t1=new task();
        t1.Status='New';
        t1.subject='test';
        t1.RecordtypeID = Util_GE_OG.getRecordTypeDetails('Task','Deal Machine Task').getRecordTypeId();
        t1.whatid=p.id;
        t1.type = 'Customer Meeting';
        t1.Activitydate = Date.newInstance(2018, 12, 9);
        insert t1;
        
                       
       
        task t4=new task();
        t4.Status='New';
        t4.subject='test';
        t4.RecordtypeID = Util_GE_OG.getRecordTypeDetails('Task','Deal Machine Task').getRecordTypeId();
        t4.whatid=at.id;
        t4.type = 'Customer Meeting';
        t4.Activitydate = Date.newInstance(2018, 12, 9);
        insert t4;  
        
        
        task t5=new task();
        t5.Status='New';
        t5.subject='test';
        t5.RecordtypeID = Util_GE_OG.getRecordTypeDetails('Task','Deal Machine Task').getRecordTypeId();
        t5.whatid=p1.id;
        t5.type = 'Customer Meeting';
        t5.Activitydate = Date.newInstance(2018, 12, 9);
        insert t5;  
                
        
       
        
        
        PostChatteronAccount c = new PostChatteronAccount();  
   
   
   
   
   test.stoptest();
            

    }    





}