@isTest
private class GE_PW_WES_Test_Disposition
 {
     static testMethod void DispositionLinkMethods() 
       {
         try{
         Account accObj = new Account() ;
         Account accObj1 = new Account();
         List<Account> accList = [select id, name,  GE_HQ_Request_Status__c, BillingCountry, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry, GE_HQ_SIC1__c, GE_HQ_SIC2__c, GE_HQ_SIC3__c from Account where name= 'TestClassAccount-EndUser' or name ='TestClassAccount-ShipTo' limit 2];
         
         for(Account a: accList){
             if(a.name == 'TestClassAccount-ShipTo')
                accObj = a;
             else 
                accObj = a; 
         }
         
         if(accObj != null ){
         Opportunity Oppty1 = new Opportunity(name='test Oppty One1');
         Oppty1.Accountid=accObj.id;
         Oppty1.StageName = 'Test';
         Oppty1.CloseDate = Date.today();      
       //  Oppty1.GE_PW_DEV_Application__c='Brackish Desal';    
         Oppty1.Type ='Flow-Direct/Indirect';  
         Oppty1.LeadSource='Other';  
         Oppty1.tier_1_ge_og__c='Power & Water (P&W)';     
         Oppty1.tier_2_ge_og__c='Water';    
         Oppty1.tier_3_ge_og__c ='Engineered Systems (WES)';
         insert Oppty1;
         Oppty1.StageName ='Test1';
         update Oppty1;            
                
           GE_PW_Strategic_Deal_Information__c SDI = new GE_PW_Strategic_Deal_Information__c();  
           SDI.GE_PW_Opportunity__c = Oppty1.id;
           SDI.GE_PW_Advantages_our_partners_bring__c = 'test';
           SDI.GE_PW_CTQ_1_Weight__c='50';
           SDI.GE_PW_CTQ_2_Weight__c='30';           
           SDI.GE_PW_CTQ_3_Weight__c='10';
           SDI.GE_PW_CTQ_4_Weight__c='10';
           SDI.GE_PW_Customer_CTQ_1__c ='Highest Recovery';  
           SDI.GE_PW_Customer_CTQ_2__c ='Test1';
           SDI.GE_PW_Customer_CTQ_3__c ='Test2'; 
           SDI.GE_PW_Customer_CTQ_4__c ='Test3';          
             insert SDI;          
      
        /* GE_PW_Strategic_Deal_Competitor__c Comp = new GE_PW_Strategic_Deal_Competitor__c();
          Comp.GE_PW_Opportunity__c = Oppty1.id;         
           Comp.GE_PW_Strategic_Deal_Info__c=SDI.id; 
            Comp.GE_PW_Customer_CTQ_1__c='Highest Recovery'; 
            Comp.GE_PW_Customer_CTQ_2__c='Test1';  
            Comp.GE_PW_Customer_CTQ_3__c='Test2'; 
            Comp.GE_PW_Customer_CTQ_4__c='Test3';           
           
         insert Comp;*/
         }
         }Catch(Exception ex){}
} 

static testMethod void GE_PW_PreventDispositionStageUpdate() 
       {
       
          try{
           Account accObj = new Account() ;
           Account accObj1 = new Account();
            
           List<Account> accList = [select id, name,  GE_HQ_Request_Status__c, BillingCountry, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry, GE_HQ_SIC1__c, GE_HQ_SIC2__c, GE_HQ_SIC3__c from Account where name= 'TestClassAccount-EndUser' or name ='TestClassAccount-ShipTo' limit 2];
           for(Account a: accList){
             if(a.name == 'TestClassAccount-ShipTo')
                accObj = a;
             else 
                accObj = a;           
           }
               //create a Opportunity            
            
            if(accObj != null ){
                    Opportunity Opp =new Opportunity();
                    Opp.Accountid=accObj.id;    
                    Opp.name='testing sales team';      
                    Opp.StageName='R1'; 
                    Opp.tier_1_ge_og__c='Power & Water (P&W)';     
                    Opp.tier_2_ge_og__c='Water';    
                    Opp.tier_3_ge_og__c ='Engineered Systems (WES)'; 
                    Opp.CloseDate=Date.newInstance(2010,5,5);            
                    insert Opp;
            }
       }
       
       Catch(Exception ex){}
 }
 
 }