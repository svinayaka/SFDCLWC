@isTest
Public Class GE_PRM_Contract_Trigger_Handler_Test
{
   Private static Account acc;    
   Private static Account acc1;
   Private static Account acc11;
   Private static Account accCountry;
   Private static GE_PRM_Channel_Appointment__c ChApp;  
   Private static GE_PRM_Commercial_line__c commline;
   Private static Contract master;
   Private static Contract addedum;   
   Private static profile myChannelMgr= [select id from profile where name = 'OG_Sales/Comm Ops' limit 1];  
   Private static User chnlMangr;
   Private static list<Contract>  contractstoinsert=new list<Contract>();
   
   
   /* static testmethod void Test_Update_acc_hier()
     {
        Load_data();      
        System.assertEquals(ChApp.GE_PRM_Tier_2_P_L__c,'Measurement & Control (M&C)');       
        apexpages.currentpage().getparameters().put('id' ,ChApp.id);        
        addedum.status = 'Activated';       
           System.runas(chnlMangr)
             {
                update addedum;
             } 
         GE_PRM_Contract_Trigger_Handler handler = new GE_PRM_Contract_Trigger_Handler();
         map<id,Contract> mapCon = new map<id,contract>();
         contract cc=  addedum.clone(true);
         cc.status = 'Executed';
         mapCon.put(addedum.id,cc); 
           
    } 
    static testmethod void Test_Update_accHier_isRunFromBatch()
     {
        Load_data();      
        System.assertEquals(ChApp.GE_PRM_Tier_2_P_L__c,'Measurement & Control (M&C)');       
        apexpages.currentpage().getparameters().put('id' ,ChApp.id);        
        addedum.status = 'Activated';
         GE_PRM_Contract_Trigger_Handler handler = new GE_PRM_Contract_Trigger_Handler();
         handler.isRunFromBatch =true;
         map<id,Contract> mapCon = new map<id,contract>();
         contract cc=  addedum.clone(true);
         cc.status = 'Executed';
         mapCon.put(addedum.id,cc); 
         System.runas(chnlMangr)
          {
             handler.update_acc_hier(contractstoinsert,mapCon);
          }   
    } */
 /*   static testmethod void onDeleteMethod(){
        Load_data();
        test.startTest();  
        
           // adding ACCOUNT OF TYPE CMF approved record type for L.E
        acc11=new Account();          
        acc11.name = 'Test';
        acc11.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();

        acc11.Account_Status__c = 'CC Approved';
        //acc11.Oil_Gas_Parent_Account__c  = accCountry.id;
        acc11.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc11.GE_HQ_Site_Use_Code__c = 'BOTH';
        acc11.Phone = '03332342345';
        acc11.ShippingStreet = 'test'; 
        acc11.ShippingCity = 'test';
        acc11.ShippingState = 'test';
        acc11.Account_Tier_GEOG__c ='Global';
        acc11.ShippingPostalCode = '1245521';
        acc11.ShippingCountry = 'TOGO';
        acc11.BillingCity = 'test';
        acc11.BillingCountry = 'TOGO'; 
        acc11.BillingPostalCode = '1235412';
        acc11.BillingState = 'test';
        acc11.BillingStreet = 'test';
        acc11.GE_PW_Street_Quote_To_Sold_To_HQ__c = 'test';
        acc11.GE_PW_Phone_Quote_To_Sold_To_HQ__c = '111111111';
        acc11.GE_PW_City_Quote_To_Sold_To_HQ__c = 'test';
        acc11.GE_PW_State_Province_Quote_To_Sold_To_HQ__c = 'test';
        acc11.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c = 'test';
        acc11.GE_PW_Street_Bill_To__c = 'test';
        acc11.GE_PW_City_Bill_To__c = 'test';
        acc11.GE_PW_State_Province_Bill_To__c = 'test'; 
        acc11.GE_PW_Zip_Postal_Code_Bill_To__c = '2524525';
        acc11.GE_PW_Street_Ship_To__c = 'test';
        acc11.GE_PW_City_Ship_To__c = 'test';
        acc11.GE_PW_State_Province_Ship_To__c = 'test'; 
        acc11.GE_PW_Zip_Postal_Code_Ship_To__c = '2554852';
        acc11.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'TOGO';
        acc11.GE_PW_Country_Bill_To__c = 'TOGO';
        acc11.GE_PW_Country_Ship_To__c = 'TOGO';
        acc11.GE_PW_Send_to_CMF_Bill_To__c = true;
        acc11.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c = true;
        acc11.GE_PW_Send_to_CMF_Ship_To__c = true;      
        acc11.GE_PW_Latitude_Bill_To__c = '10.242454';
        acc11.GE_PW_Longitude_Bill_To__c = '20.041244';
        acc11.GE_PW_Latitude_Quote_To_Sold_To_HQ__c = '10.24245';
        acc11.GE_PW_Longitude_Quote_To_Sold_To_HQ__c = '20.1255';
        acc11.GE_PW_Latitude_Ship_To__c = '35.1044411';
        acc11.GE_PW_Longitude_Ship_To__c = '2.012255';
        acc11.GE_PW_Phone_Bill_To__c = '0212142121';
        acc11.GE_PW_Phone_Ship_To__c = '020124512';
        acc11.GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c = false;
        acc11.GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c = false;
        acc11.GE_HQ_DB_DUNS__c = '254123452';
        acc11.GE_PW_DB_DUNS_BillTo__c = '254215454';
        acc11.GE_PW_DB_DUNS_New_Request__c = '235124542';
        acc11.GE_PW_DB_DUNS_QuoteTo__c = '547254254';
        acc11.GE_PW_DB_DUNS_ShipTo__c = '652150545';
        acc11.GE_HQ_New_Account_City__c = 'test';
        acc11.GE_HQ_New_Account_Street__c = 'test';
        acc11.GE_HQ_New_Account_State_Province__c = 'test';
        acc11.GE_HQ_New_Account_Zip_Postal_Code__c = '6757474';
        acc11.GE_HQ_New_Account_Country__c = 'TOGO';
        acc11.Type = 'Direct Customer';   
        insert acc11;
        system.debug(' inserted account of cmf approved type'+acc11);
        
    // done with adding CMF approved recordtype account(L.E)    
            
        Contract testContract =new  Contract();

     /*   testContract.accountId ==acc1.id;
        testContract.GE_Commercial_Member_Of_GE_OG__c  = acc1.Id;
        testContract.GE_PRM_Commercial_Account__c = acc1.Id;
     */   
        
        //testContract.accountId = acc11.id;
       // testContract.GE_Commercial_Member_Of_GE_OG__c  = acc.Id;
       // testContract.GE_PRM_Commercial_Account__c = accCountry.Id;
        
        /* System.runas(chnlMangr)
             {
                insert testContract;
                delete testContract;
             }
        test.stopTest();
    } */
    
  /*  public static testMethod void testActiveInactive(){
        test.startTest();
        List<Account> newAccnts = new List<Account>();
    
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = 'Account Global';
        acc.Account_Tier_GEOG__c = 'Global';
        acc.Classification__c= 'Strategic';
        acc.ShippingCountry = 'India';
        acc.Type = 'Direct Customer';
        insert acc;
        //newAccnts.add(acc);
        
        //Creating Regional account
        account accRegional = new account();
        accRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accRegional.name = 'Test Account Regional';
        accRegional.Account_Tier_GEOG__c = 'Regional';
        accRegional.Country_GEOG__c = 'INDIA';
        accRegional.Classification__c= 'Strategic';
        accRegional.ShippingCountry = 'India';
        accRegional.Member_of_GE_OG__c = acc.Id;
        accRegional.ParentId = acc.Id;
        accRegional.Type = 'Direct Customer';
        insert accRegional;
        //newAccnts.add(accRegional);
          
        //Creating Country account
        account accCountry = new account();
        //accCountry = new account();

        accCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accCountry.name = 'Test Account Country';
        accCountry.Account_Tier_GEOG__c = 'Global';
        accCountry.Country_GEOG__c = 'INDIA';
        accCountry.Classification__c= 'Strategic';
        accCountry.ShippingCountry = 'India';
        accCountry.Member_of_GE_OG__c = acc.Id;
        accCountry.ParentId = accRegional.Id;
        accCountry.Finance_Lock_GEOG__c = True;
        accCountry.Compliance_Ready__c  =  False;
        accCountry.Type = 'Direct Customer';
        insert accCountry;
        
        Account acc1=new Account();          
        acc1.name = 'Test';
        acc1.Account_Status__c = 'New';
        acc1.Oil_Gas_Parent_Account__c  = accCountry.id;
        acc1.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc1.GE_HQ_Site_Use_Code__c = 'BOTH';
        acc1.Phone = '03332342345';
        acc1.ShippingStreet = 'test'; 
        acc1.ShippingCity = 'test';
        acc1.ShippingState = 'test';
        acc1.Account_Tier_GEOG__c ='Global';
        acc1.ShippingPostalCode = '1245521';
        acc1.ShippingCountry = 'TOGO';
        acc1.BillingCity = 'test';
        acc1.BillingCountry = 'TOGO'; 
        acc1.BillingPostalCode = '1235412';
        acc1.BillingState = 'test';
        acc1.BillingStreet = 'test';
        acc1.GE_PW_Street_Quote_To_Sold_To_HQ__c = 'test';
        acc1.GE_PW_Phone_Quote_To_Sold_To_HQ__c = '111111111';
        acc1.GE_PW_City_Quote_To_Sold_To_HQ__c = 'test';
        acc1.GE_PW_State_Province_Quote_To_Sold_To_HQ__c = 'test';
        acc1.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c = 'test';
        acc1.GE_PW_Street_Bill_To__c = 'test';
        acc1.GE_PW_City_Bill_To__c = 'test';
        acc1.GE_PW_State_Province_Bill_To__c = 'test'; 
        acc1.GE_PW_Zip_Postal_Code_Bill_To__c = '2524525';
        acc1.GE_PW_Street_Ship_To__c = 'test';
        acc1.GE_PW_City_Ship_To__c = 'test';
        acc1.GE_PW_State_Province_Ship_To__c = 'test'; 
        acc1.GE_PW_Zip_Postal_Code_Ship_To__c = '2554852';
        acc1.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'TOGO';
        acc1.GE_PW_Country_Bill_To__c = 'TOGO';
        acc1.GE_PW_Country_Ship_To__c = 'TOGO';
        acc1.GE_PW_Send_to_CMF_Bill_To__c = true;
        acc1.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c = true;
        acc1.GE_PW_Send_to_CMF_Ship_To__c = true;      
        acc1.GE_PW_Latitude_Bill_To__c = '10.242454';
        acc1.GE_PW_Longitude_Bill_To__c = '20.041244';
        acc1.GE_PW_Latitude_Quote_To_Sold_To_HQ__c = '10.24245';
        acc1.GE_PW_Longitude_Quote_To_Sold_To_HQ__c = '20.1255';
        acc1.GE_PW_Latitude_Ship_To__c = '35.1044411';
        acc1.GE_PW_Longitude_Ship_To__c = '2.012255';
        acc1.GE_PW_Phone_Bill_To__c = '0212142121';
        acc1.GE_PW_Phone_Ship_To__c = '020124512';
        acc1.GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c = false;
        acc1.GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c = false;
        acc1.GE_HQ_DB_DUNS__c = '254123452';
        acc1.GE_PW_DB_DUNS_BillTo__c = '254215454';
        acc1.GE_PW_DB_DUNS_New_Request__c = '235124542';
        acc1.GE_PW_DB_DUNS_QuoteTo__c = '547254254';
        acc1.GE_PW_DB_DUNS_ShipTo__c = '652150545';
        acc1.GE_HQ_New_Account_City__c = 'test';
        acc1.GE_HQ_New_Account_Street__c = 'test';
        acc1.GE_HQ_New_Account_State_Province__c = 'test';
        acc1.GE_HQ_New_Account_Zip_Postal_Code__c = '6757474';
        acc1.GE_HQ_New_Account_Country__c = 'TOGO';
        acc1.Type = 'Direct Customer';   
        insert acc1;
        
        Contract testContract =new  Contract();
        testContract.accountId = acc1.id;
        testContract.GE_Commercial_Member_Of_GE_OG__c  = accCountry.Id;
        testContract.GE_PRM_Commercial_Account__c = accCountry.Id;
        insert testContract;
        
        testContract.status = 'Executed';
        update testContract;
        test.stopTest();
    } */
    
 /*   public static testMethod void testActiveInactive2(){
        test.startTest();
        List<Account> newAccnts = new List<Account>();
    
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = 'Account Global';
        acc.Account_Tier_GEOG__c = 'Global';
        acc.Classification__c= 'Strategic';
        acc.ShippingCountry = 'India';
        acc.Type = 'Direct Customer';
        insert acc;
        //newAccnts.add(acc);
        
        //Creating Regional account
        account accRegional = new account();
        accRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accRegional.name = 'Test Account Regional';
        accRegional.Account_Tier_GEOG__c = 'Regional';
        accRegional.Country_GEOG__c = 'INDIA';
        accRegional.Classification__c= 'Strategic';
        accRegional.ShippingCountry = 'India';
        accRegional.Member_of_GE_OG__c = acc.Id;
        accRegional.ParentId = acc.Id;
        accRegional.Type = 'Direct Customer';
        insert accRegional;
        //newAccnts.add(accRegional);
          
        //Creating Country account
        account accCountry = new account();
        accCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accCountry.name = 'Test Account Country';
        accCountry.Account_Tier_GEOG__c = 'Global';
        accCountry.Country_GEOG__c = 'INDIA';
        accCountry.Classification__c= 'Strategic';
        accCountry.ShippingCountry = 'India';
        accCountry.Member_of_GE_OG__c = acc.Id;
        accCountry.ParentId = accRegional.Id;
        accCountry.Finance_Lock_GEOG__c = True;
        accCountry.Compliance_Ready__c  =  False;
        accCountry.Type = 'Direct Customer';
        insert accCountry;
        
        Account acc1=new Account();          
        acc1.name = 'Test';
        acc1.Account_Status__c = 'New';
        acc1.Oil_Gas_Parent_Account__c  = accCountry.id;
        acc1.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc1.GE_HQ_Site_Use_Code__c = 'BOTH';
        acc1.Phone = '03332342345';
        acc1.ShippingStreet = 'test'; 
        acc1.ShippingCity = 'test';
        acc1.ShippingState = 'test';
        acc1.Account_Tier_GEOG__c ='Global';
        acc1.ShippingPostalCode = '1245521';
        acc1.ShippingCountry = 'TOGO';
        acc1.BillingCity = 'test';
        acc1.BillingCountry = 'TOGO'; 
        acc1.BillingPostalCode = '1235412';
        acc1.BillingState = 'test';
        acc1.BillingStreet = 'test';
        acc1.GE_PW_Street_Quote_To_Sold_To_HQ__c = 'test';
        acc1.GE_PW_Phone_Quote_To_Sold_To_HQ__c = '111111111';
        acc1.GE_PW_City_Quote_To_Sold_To_HQ__c = 'test';
        acc1.GE_PW_State_Province_Quote_To_Sold_To_HQ__c = 'test';
        acc1.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c = 'test';
        acc1.GE_PW_Street_Bill_To__c = 'test';
        acc1.GE_PW_City_Bill_To__c = 'test';
        acc1.GE_PW_State_Province_Bill_To__c = 'test'; 
        acc1.GE_PW_Zip_Postal_Code_Bill_To__c = '2524525';
        acc1.GE_PW_Street_Ship_To__c = 'test';
        acc1.GE_PW_City_Ship_To__c = 'test';
        acc1.GE_PW_State_Province_Ship_To__c = 'test'; 
        acc1.GE_PW_Zip_Postal_Code_Ship_To__c = '2554852';
        acc1.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'TOGO';
        acc1.GE_PW_Country_Bill_To__c = 'TOGO';
        acc1.GE_PW_Country_Ship_To__c = 'TOGO';
        acc1.GE_PW_Send_to_CMF_Bill_To__c = true;
        acc1.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c = true;
        acc1.GE_PW_Send_to_CMF_Ship_To__c = true;      
        acc1.GE_PW_Latitude_Bill_To__c = '10.242454';
        acc1.GE_PW_Longitude_Bill_To__c = '20.041244';
        acc1.GE_PW_Latitude_Quote_To_Sold_To_HQ__c = '10.24245';
        acc1.GE_PW_Longitude_Quote_To_Sold_To_HQ__c = '20.1255';
        acc1.GE_PW_Latitude_Ship_To__c = '35.1044411';
        acc1.GE_PW_Longitude_Ship_To__c = '2.012255';
        acc1.GE_PW_Phone_Bill_To__c = '0212142121';
        acc1.GE_PW_Phone_Ship_To__c = '020124512';
        acc1.GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c = false;
        acc1.GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c = false;
        acc1.GE_HQ_DB_DUNS__c = '254123452';
        acc1.GE_PW_DB_DUNS_BillTo__c = '254215454';
        acc1.GE_PW_DB_DUNS_New_Request__c = '235124542';
        acc1.GE_PW_DB_DUNS_QuoteTo__c = '547254254';
        acc1.GE_PW_DB_DUNS_ShipTo__c = '652150545';
        acc1.GE_HQ_New_Account_City__c = 'test';
        acc1.GE_HQ_New_Account_Street__c = 'test';
        acc1.GE_HQ_New_Account_State_Province__c = 'test';
        acc1.GE_HQ_New_Account_Zip_Postal_Code__c = '6757474';
        acc1.GE_HQ_New_Account_Country__c = 'TOGO';
        acc1.Type = 'Direct Customer';   
        insert acc1;
        
        Contract testContract =new  Contract();
        testContract.accountId = acc1.id;
        testContract.GE_Commercial_Member_Of_GE_OG__c  = accCountry.Id;
        testContract.GE_PRM_Commercial_Account__c = accCountry.Id;
        testContract.status = 'Executed';
        insert testContract;
        
        testContract.status = 'Generate Draft';
        update testContract;
        
        
        test.stopTest();
    } */
   /* Private static void Load_data(){
       Insert_User();
       Insert_Account();
       Insert_ChannelsAppointment();
       Insert_Commercial_lines();
       Insert_Contracts();
   }
   */
 /*  Private static void Insert_User()
     {
      User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
      System.runAs (thisUser) {
        

       chnlMangr = new User();
       chnlMangr.firstname = 'channel';
       chnlMangr.lastname = 'managerBHI';
       chnlMangr.email = 'chnmanager@bhge.com';
       chnlMangr.alias = 'chnbhge';
       chnlMangr.profileId = myChannelMgr.ID;
       chnlMangr.Title = 'Channel Manager';
       chnlMangr.Username = 'channelmagar@bhge.com';
       chnlMangr.CommunityNickname = 'chbhge';
       chnlMangr.TimeZoneSidKey = 'America/New_York';
       chnlMangr.LocaleSidKey = 'en_US';
       chnlMangr.EmailEncodingKey= 'ISO-8859-1';
       chnlMangr.LanguageLocaleKey= 'en_US';
       insert chnlMangr;
       }
     }  
    Private static void Insert_Account()
     {
        list<Account> lstacc = new List<Account>();
        acc=new Account();          
        acc.name = 'Test';
        acc.Account_Status__c = 'New';
        acc.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc.GE_HQ_Site_Use_Code__c = 'BOTH';
        acc.Phone = '03332342345';
        acc.ShippingStreet = 'test'; 
        acc.ShippingCity = 'test';
        acc.ShippingState = 'test';
        acc.ShippingPostalCode = '1245521';
        acc.ShippingCountry = 'TOGO';
        acc.BillingCity = 'test';
        acc.BillingCountry = 'TOGO'; 
        acc.BillingPostalCode = '1235412';
        acc.BillingState = 'test';
        acc.BillingStreet = 'test';
        acc.GE_PW_Street_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_Phone_Quote_To_Sold_To_HQ__c = '111111111';
        acc.GE_PW_City_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c = 'test';
        acc.GE_PW_Street_Bill_To__c = 'test';
        acc.GE_PW_City_Bill_To__c = 'test';
        acc.GE_PW_State_Province_Bill_To__c = 'test'; 
        acc.GE_PW_Zip_Postal_Code_Bill_To__c = '2524525';
        acc.GE_PW_Street_Ship_To__c = 'test';
        acc.GE_PW_City_Ship_To__c = 'test';
        acc.GE_PW_State_Province_Ship_To__c = 'test'; 
        acc.GE_PW_Zip_Postal_Code_Ship_To__c = '2554852';
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'TOGO';
        acc.GE_PW_Country_Bill_To__c = 'TOGO';
        acc.GE_PW_Country_Ship_To__c = 'TOGO';
        acc.GE_PW_Send_to_CMF_Bill_To__c = true;
        acc.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c = true;
        acc.GE_PW_Send_to_CMF_Ship_To__c = true;      
        acc.GE_PW_Latitude_Bill_To__c = '10.242454';
        acc.GE_PW_Longitude_Bill_To__c = '20.041244';
        acc.GE_PW_Latitude_Quote_To_Sold_To_HQ__c = '10.24245';
        acc.GE_PW_Longitude_Quote_To_Sold_To_HQ__c = '20.1255';
        acc.GE_PW_Latitude_Ship_To__c = '35.1044411';
        acc.GE_PW_Longitude_Ship_To__c = '2.012255';
        acc.GE_PW_Phone_Bill_To__c = '0212142121';
        acc.GE_PW_Phone_Ship_To__c = '020124512';
        acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c = false;
        acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c = false;
        acc.GE_HQ_DB_DUNS__c = '254123452';
        acc.GE_PW_DB_DUNS_BillTo__c = '254215454';
        acc.GE_PW_DB_DUNS_New_Request__c = '235124542';
        acc.GE_PW_DB_DUNS_QuoteTo__c = '547254254';
        acc.GE_PW_DB_DUNS_ShipTo__c = '652150545';
        acc.GE_HQ_New_Account_City__c = 'test';
        acc.GE_HQ_New_Account_Street__c = 'test';
        acc.GE_HQ_New_Account_State_Province__c = 'test';
        acc.GE_HQ_New_Account_Zip_Postal_Code__c = '6757474';
        acc.GE_HQ_New_Account_Country__c = 'TOGO';   
        lstacc.add(acc);   
        
        acc1=new Account();          
        acc1.name = 'Test';
        acc1.Account_Status__c = 'New';
        acc1.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc1.GE_HQ_Site_Use_Code__c = 'BOTH';
        acc1.Phone = '03332342345';
        acc1.ShippingStreet = 'test'; 
        acc1.ShippingCity = 'test';
        acc1.ShippingState = 'test';
        acc1.Account_Tier_GEOG__c ='Global';
        acc1.ShippingPostalCode = '1245521';
        acc1.ShippingCountry = 'TOGO';
        acc1.BillingCity = 'test';
        acc1.BillingCountry = 'TOGO'; 
        acc1.BillingPostalCode = '1235412';
        acc1.BillingState = 'test';
        acc1.BillingStreet = 'test';
        acc1.GE_PW_Street_Quote_To_Sold_To_HQ__c = 'test';
        acc1.GE_PW_Phone_Quote_To_Sold_To_HQ__c = '111111111';
        acc1.GE_PW_City_Quote_To_Sold_To_HQ__c = 'test';
        acc1.GE_PW_State_Province_Quote_To_Sold_To_HQ__c = 'test';
        acc1.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c = 'test';
        acc1.GE_PW_Street_Bill_To__c = 'test';
        acc1.GE_PW_City_Bill_To__c = 'test';
        acc1.GE_PW_State_Province_Bill_To__c = 'test'; 
        acc1.GE_PW_Zip_Postal_Code_Bill_To__c = '2524525';
        acc1.GE_PW_Street_Ship_To__c = 'test';
        acc1.GE_PW_City_Ship_To__c = 'test';
        acc1.GE_PW_State_Province_Ship_To__c = 'test'; 
        acc1.GE_PW_Zip_Postal_Code_Ship_To__c = '2554852';
        acc1.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'TOGO';
        acc1.GE_PW_Country_Bill_To__c = 'TOGO';
        acc1.GE_PW_Country_Ship_To__c = 'TOGO';
        acc1.GE_PW_Send_to_CMF_Bill_To__c = true;
        acc1.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c = true;
        acc1.GE_PW_Send_to_CMF_Ship_To__c = true;      
        acc1.GE_PW_Latitude_Bill_To__c = '10.242454';
        acc1.GE_PW_Longitude_Bill_To__c = '20.041244';
        acc1.GE_PW_Latitude_Quote_To_Sold_To_HQ__c = '10.24245';
        acc1.GE_PW_Longitude_Quote_To_Sold_To_HQ__c = '20.1255';
        acc1.GE_PW_Latitude_Ship_To__c = '35.1044411';
        acc1.GE_PW_Longitude_Ship_To__c = '2.012255';
        acc1.GE_PW_Phone_Bill_To__c = '0212142121';
        acc1.GE_PW_Phone_Ship_To__c = '020124512';
        acc1.GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c = false;
        acc1.GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c = false;
        acc1.GE_HQ_DB_DUNS__c = '254123452';
        acc1.GE_PW_DB_DUNS_BillTo__c = '254215454';
        acc1.GE_PW_DB_DUNS_New_Request__c = '235124542';
        acc1.GE_PW_DB_DUNS_QuoteTo__c = '547254254';
        acc1.GE_PW_DB_DUNS_ShipTo__c = '652150545';
        acc1.GE_HQ_New_Account_City__c = 'test';
        acc1.GE_HQ_New_Account_Street__c = 'test';
        acc1.GE_HQ_New_Account_State_Province__c = 'test';
        acc1.GE_HQ_New_Account_Zip_Postal_Code__c = '6757474';
        acc1.GE_HQ_New_Account_Country__c = 'TOGO';   
        lstacc.add(acc1); 
        System.RunAs(chnlMangr){  
        insert lstacc; }
  
     }
    Private static void Insert_ChannelsAppointment()
     {
        ChApp = new GE_PRM_Channel_Appointment__c();
        ChApp.GE_PRM_Account_Name__c=acc.id;
        ChApp.GE_PRM_Current_Status__c= 'Approved'; 
        ChApp.GE_PRM_Master_appointment_type__c ='New';
        ChApp.GE_PRM_Primary_bank_account_country__c = 'UNITED KINGDOM ';
        ChApp.GE_PRM_Primary_bank_name_address__c = 'test';
        ChApp.GE_PRM_Primary_bank_contact__c = 'test';
        ChApp.GE_PRM_Primary_bank_account__c = 'test';
        ChApp.GE_PRM_Payment_term_requested__c= '30';
        ChApp.GE_PRM_Commercial_quali_rationale__c='abcde';
        ChApp.GE_PRM_Prior_growth_rating__c = 'Medium';
        ChApp.GE_PRM_Prior_year_commission_paid__c='New';
        ChApp.GE_PRM_Prior_performance_rating__c = 'Medium';
        ChApp.GE_PRM_Prior_year_orders__c = '<$100K';
        ChApp.GE_PRM_With_GE_since__c = 0;
        ChApp.GE_PRM_In_Business_Since__c = Date.today();
        ChApp.GE_PRM_Mandated_by_End_Customer__c = 'No';
        ChApp.GE_PRM_Convicted_of_any_felony_crims_r_s__c= 'No';
        ChApp.GE_PRM_Do_you_have_Officers_in_Gov__c= 'No';
        ChApp.GE_PRM_High_Risk_product_lines__c= 'No';
        ChApp.GE_PRM_Sell_to_Nuclear_industry__c= 'No';
        ChApp.GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c= 'No';
        ChApp.GE_PRM_Does_Channel_Partner_have_subsid__c= 'No';
        ChApp.GE_PRM_Export_Controlled_products__c= 'No';
        ChApp.GE_PRM_Export_outside_own_country__c= 'No';
        ChApp.GE_PRM_Approved_exclusivity_from_P_L__c= 'No';
        ChApp.GE_PRM_Primary_Sales_Channel_Manager__c=chnlMangr.id;
        ChApp.GE_PRM_Region_Sales_Channel_Leader__c=chnlMangr.id;       
        ChApp.GE_PRM_Tier_2_P_L__c='Measurement & Control (M&C)'; 
        System.RunAs(chnlMangr){
        insert ChApp;    
        }
     }
    Private static void Insert_Commercial_lines()
     { 
        commline= new GE_PRM_Commercial_line__c();
        commline.GE_PRM_Channel_Appointment__c=ChApp.id;
        commline.GE_PRM_Status__c='New';       
        commline.GE_PRM_Tier_1__c='Oil & Gas (O&G)';
        commline.GE_PRM_Tier_2__c='Measurement & Control (M&C)';
        commline.GE_PRM_Tier_3__c='Bently Nevada';
        commline.GE_PRM_Tier_4__c='Application';
        commline.GE_PRM_Tier_5__c= 'Test';
        commline.GE_PRM_Type__c='Sales Representative';
        commline.GE_PRM_Channel_Appointment__c=ChApp.id;
        commline.GE_PRM_If_Services_pick_type__c='MARC';
        commline.GE_PRM_Term__c=8;
        commline.GE_PRM_If_flat_pricing__c=80;
        commline.GE_PRM_Is_this_linked_to_project_oppty__c='No';
        commline.GE_PRM_Military_use_Add_comment__c='No';
        commline.GE_PRM_Inclusions_exclusions_Add_comment__c='No';
        commline.GE_PRM_Nuclear_use_Add_comment__c='No';
        commline.GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c='Standard';
        commline.GE_PRM_Authorized_Countries_1__c='BANGLADESH;BARBADOS';
        commline.GE_PRM_Authorized_Countries_2__c='UNITED STATES;UNITED KINGDOM';  
        System.RunAs(chnlMangr){      
            insert commline;
        }
     } */
     public static testMethod void testNewPRMContracts()
     {
          Id adendumdRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Addendum').getRecordTypeId();
          Id ammendRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Amendment').getRecordTypeId();
          Id masterRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Master Agreement').getRecordTypeId();
    
        Map<Id,Contract> memberOfContractMap = new Map<Id,Contract>();
        Map<Id,Contract> leContractMap = new Map<Id,Contract>();
        account accCountryHQ = new account();
        accCountryHQ.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        accCountryHQ.name = 'Test Account OLD HQ';
        accCountryHQ.Account_Tier_GEOG__c = 'Global';
        accCountryHQ.Country_GEOG__c = 'INDIA';
        accCountryHQ.Classification__c= 'Unclassified';
        accCountryHQ.Type = 'Direct Customer';
        accCountryHQ.ShippingCountry = 'India';
        //accCountry.Member_of_GE_OG__c = acc.Id;
        //accCountry.ParentId = accRegional.Id;
        insert accCountryHQ;
    
       account accCountry = new account();
        accCountry.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        accCountry.name = 'Test Account old country';
        accCountry.Account_Tier_GEOG__c = 'Country';
        accCountry.Country_GEOG__c = 'INDIA';
        accCountry.Classification__c= 'Unclassified';
        accCountry.Type = 'Direct Customer';
        accCountry.ShippingCountry = 'India';
        accCountry.Member_of_GE_OG__c = accCountryHQ.Id;
        //accCountry.ParentId = accRegional.Id;
        insert accCountry;
        
         account accLE = new account();
        accLE.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        accLE.name = 'Test Account LE';
        accLE.Account_Tier_GEOG__c = 'LE';
        accLE.Oil_Gas_Parent_Account__c = accCountry.Id;
        accLE.Country_GEOG__c = 'INDIA';
        accLE.Type = 'Direct Customer';
        accLE.Classification__c = 'Do Not Contact';
        accLE.ShippingCountry = 'India';
        accLE.Account_Status__c = 'CC Approved';
        //accLE.Member_of_GE_OG__c = acc.Id;
        insert accLE;
        
        
        Contract conMaster =  new Contract();
        conMaster.RecordTypeId = masterRecordTypeId;
        conMaster.AccountId = accLE.Id;
        conMaster.GE_Commercial_Member_Of_GE_OG__c = accCountryHQ.Id;
        conMaster.GE_PRM_Commercial_Account__c = accCountry.Id;
        conMaster.Status = 'Generate Draft';
        conMaster.ContractTerm = 12;
        conMaster.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
        conMaster.GE_PRM_Contract_Draft_date__c = System.today();
        conMaster.GE_PRM_GE_Confirmed_Date__c = System.today();
        conMaster.GE_PRM_Contract_Sent_to_CP__c = System.today();
        conMaster.GE_PRM_GE_Signatures_completed__c = System.today();
        conMaster.GE_PRM_ASC_Signed_contract_received__c = System.today();
        conMaster.GE_PRM_Close_out__c = System.today();
        
        insert conMaster;
        
        conMaster.Status = 'Executed';
        update conMaster;
        
        Contract conadd =  new Contract();
        conadd.RecordTypeId = adendumdRecordTypeId;
        conadd.AccountId = accLE.Id;
        conadd.GE_Commercial_Member_Of_GE_OG__c = accCountryHQ.Id;
        conadd.GE_PRM_Commercial_Account__c = accCountry.Id;
        conadd.Status = 'Generate Draft';
        conadd.GE_ES_User_Lead_Sales_Person__c = Userinfo.getUserId();
        conadd.PRM_Master_Agreement__c = conMaster.Id;
        conadd.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
        conadd.GE_PRM_Contract_Draft_date__c = System.today();
        conadd.GE_PRM_GE_Confirmed_Date__c = System.today();
        conadd.GE_PRM_Contract_Sent_to_CP__c = System.today();
        conadd.GE_PRM_GE_Signatures_completed__c = System.today();
        conadd.GE_PRM_ASC_Signed_contract_received__c = System.today();
        conadd.GE_PRM_Close_out__c = System.today();
        conadd.ContractTerm = 12;
        insert conadd;
        
        Contract conadd2 =  new Contract();
        conadd2.RecordTypeId = adendumdRecordTypeId;
        conadd2.AccountId = accLE.Id;
        conadd2.GE_Commercial_Member_Of_GE_OG__c = accCountryHQ.Id;
        conadd2.GE_PRM_Commercial_Account__c = accCountry.Id;
        conadd2.Status = 'Generate Draft';
        conadd2.GE_ES_User_Lead_Sales_Person__c = Userinfo.getUserId();
        conadd2.PRM_Master_Agreement__c = conMaster.Id;
        conadd2.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
        conadd2.GE_PRM_Contract_Draft_date__c = System.today();
        conadd2.GE_PRM_GE_Confirmed_Date__c = System.today();
        conadd2.GE_PRM_Contract_Sent_to_CP__c = System.today();
        conadd2.GE_PRM_GE_Signatures_completed__c = System.today();
        conadd2.GE_PRM_ASC_Signed_contract_received__c = System.today();
        conadd2.GE_PRM_Close_out__c = System.today();
        conadd2.ContractTerm = 12;
        insert conadd2;
        
        conadd2.Status = 'Executed';
        update conadd2;
        
        conadd.Status = 'Archived';
        update conadd;
        
        memberOfContractMap.put(accCountryHQ.Id,conadd);
        leContractMap.put(accLE.Id,conadd);
        
        GE_PRM_Contract_Trigger_Handler.handlePRMArchivedContracts(memberOfContractMap,leContractMap);
        
        
        
        
        
     }
     
 /*   Private static void Insert_Contracts()
     {
         String contractRecordTypeAddendumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
         String contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
        
         master=new  Contract();
                    master.RecordTypeId= contractRecordTypeMasterId ;
                    master.GE_PRM_Channel_Appointment_ID__c=ChApp.id;
                    master.accountid =ChApp.GE_PRM_Account_Name__c;
                    master.GE_PRM_Primary_Sales_Channel_Manager__c =ChApp.GE_PRM_Primary_Sales_Channel_Manager__c;
                    system.debug('commid--->'+ChApp.GE_PRM_Commercial_Manager__c);
                    master.GE_PRM_Commercial_Manager1__c=ChApp.GE_PRM_Commercial_Manager__c;
                    master.GE_PRM_Tier_2__c=ChApp.GE_PRM_Tier_2_P_L__c;
                    master.GE_PRM_Region__c=ChApp.GE_PRM_O_G_Region__c;
                    master.StartDate =Date.today();
                    master.status = 'Executed';
                    master.GE_PRM_For_Cause__c = 'Upon Notice';
                    master.GE_PRM_Without_Cause__c = '30 days';
                    master.GE_Contract_Specialist__c = chnlMangr.ID; 
                    master.GE_PRM_Contract_Draft_date__c =Date.today();
                    master.GE_PRM_Contract_Sent_to_CP__c =Date.today();
                    master.GE_PRM_ASC_Signed_contract_received__c =Date.today();
                    master.GE_PRM_GE_Signatures_completed__c =Date.today();
                    master.GE_PRM_Close_out__c =Date.today();
                    master.Hold_Flag__c = FALSE;                    
                    contractstoinsert.add(master);
        
        
                    
         addedum=new  Contract();
                    addedum.GE_PRM_Commercial_line__c = commline.Id;
                    addedum.GE_Commercial_Member_Of_GE_OG__c  = acc1.Id;
                    addedum.GE_PRM_Commercial_Account__c = acc1.Id;                    
                    addedum.RecordTypeId=contractRecordTypeAddendumId;
                    addedum.AccountID=ChApp.GE_PRM_Account_Name__c;
                    addedum.GE_ES_User_Lead_Sales_Person__c =commline.GE_PRM_Sales_Manager__c;
                    addedum.GE_PRM_Business_Tier_1__c = commline.GE_PRM_Tier_1__c;
                    addedum.GE_PRM_Tier_2__c =commline.GE_PRM_Tier_2__c;
                    addedum.GE_PRM_Tier_3__c= commline.GE_PRM_Tier_3__c;
                    addedum.GE_PRM_Tier_4__c =commline.GE_PRM_Tier_4__c;
                    addedum.GE_PRM_Tier_5__c= commline.GE_PRM_Tier_5__c;
                    addedum.GE_PRM_If_flat_Pricing__c= commline.GE_PRM_If_flat_Pricing__c;
                    addedum.GE_PRM_If_schedule_Max_Pricing__c= commline.GE_PRM_If_schedule_Max_Pricing__c;
                    addedum.GE_PRM_If_schedule_Min_Pricing__c= commline.GE_PRM_If_schedule_Min_Pricing__c;
                    addedum.GE_PRM_Industries__c= commline.GE_PRM_Industries__c;
                    addedum.GE_PRM_Buyers__c= commline.GE_PRM_Buyers__c;
                    addedum.GE_PRM_Channel_Appointment_ID__c=commline.GE_PRM_Channel_Appointment__r.id;
                    addedum.GE_PRM_Authorized_Country__c =commline.GE_PRM_Authorized_Countries_1__c + ';'+ commline.GE_PRM_Authorized_Countries_2__c;
                    addedum.GE_PRM_State_Province_Region__c =commline.GE_PRM_State_Province_Region__c;
                    addedum.GE_PRM_Pricing__c= commline.GE_PRM_Pricing__c;
                    addedum.GE_PRM_Pricing_type__c=commline.GE_PRM_Pricing_Type__c;
                    addedum.GE_PRM_Nuclear_use__c=commline.GE_PRM_Nuclear_use_Add_comment__c;
                    addedum.GE_PRM_Military_use__c =commline.GE_PRM_Military_use_Add_comment__c;
                    addedum.GE_PRM_If_Brazil_SR_SC_core__c= commline.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_SC_Core__c;
                    addedum.GE_PRM_If_Brazil_SR_CMPJ__c=commline.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_CMPJ__c;
                    addedum.GE_PRM_Inclusions_exclusions__c = commline.GE_PRM_Inclusions_exclusions_Add_comment__c;
                    addedum.GE_PRM_If_SR_sales_to_US_government__c =commline.GE_PRIf_Sales_Rep_sales_to_US_Government__c;
                    addedum.GE_PRM_Comments__c =commline.GE_PRM_if_Yes_provide_comments_SlaesRep__c;
                    addedum.GE_PRM_Commercial_Manager1__c=commline.GE_PRM_Channel_Appointment__r.GE_PRM_Commercial_Manager__c;
                    addedum.GE_PRM_Relationship_Type__c=commline.GE_PRM_Type__c;
                    addedum.StartDate =Date.today();
                    addedum.ContractTerm = integer.valueof(commline.GE_PRM_Term__c);                                    
                    addedum.GE_PRM_Primary_Sales_Channel_Manager__c =commline.GE_PRM_Channel_Appointment__r.GE_PRM_Primary_Sales_Channel_Manager__c;
                    addedum.GE_PRM_Region__c =commline.GE_PRM_Channel_Appointment__r.GE_PRM_O_G_Region__c;
                    addedum.status = 'Draft';
                    addedum.GE_PRM_Master_Agreement__c = master.ID ;
                    addedum.GE_OG_Contract_End_Date__c = Date.today();
                    contractstoinsert.add(addedum);                  
                    
                    insert contractstoinsert ;
     } */
     
  /*   Public static testMethod void Test_GE_PRM_CustomContractCreateEditDelete(){
         Insert_User();
Test.startTest();
         
         Insert_Account();
         Insert_ChannelsAppointment();
         Insert_Commercial_lines();
         Contract  master1=new  Contract();
                    master1.RecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId(); 
                    master1.GE_PRM_Channel_Appointment_ID__c=ChApp.id;
                    master1.accountid =ChApp.GE_PRM_Account_Name__c;
                    master1.GE_PRM_Primary_Sales_Channel_Manager__c = ChApp.GE_PRM_Primary_Sales_Channel_Manager__c;
                    system.debug('commid--->'+ChApp.GE_PRM_Commercial_Manager__c);
                    master1.GE_PRM_Commercial_Manager1__c=ChApp.GE_PRM_Commercial_Manager__c;
                    master1.GE_PRM_Tier_2__c=ChApp.GE_PRM_Tier_2_P_L__c;
                    master1.GE_PRM_Region__c=ChApp.GE_PRM_O_G_Region__c;
                    master1.StartDate =Date.today();
                    master1.status = 'Terminated';
                    master1.GE_PRM_For_Cause__c = 'Upon Notice';
                    master1.GE_PRM_Without_Cause__c = '30 days';
                    master1.GE_Contract_Specialist__c = chnlMangr.ID; 
                    master1.GE_PRM_Contract_Draft_date__c =Date.today();
                    master1.GE_PRM_Contract_Sent_to_CP__c =Date.today();
                    master1.GE_PRM_ASC_Signed_contract_received__c =Date.today();
                    master1.GE_PRM_GE_Signatures_completed__c =Date.today();
                    master1.GE_PRM_Close_out__c =Date.today();      
                    master1.Hold_Flag__c = FALSE; 
                    master1.Termination_Email__c=true;
                    master1.MCL_Contract__c = true;
                    contractstoinsert.add(master1);
         Contract master2  =new  Contract();
                    master2.RecordTypeId =  Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
                    master2.GE_PRM_Channel_Appointment_ID__c=ChApp.id;
                    master2.accountid =ChApp.GE_PRM_Account_Name__c;
                    master2.GE_PRM_Primary_Sales_Channel_Manager__c =ChApp.GE_PRM_Primary_Sales_Channel_Manager__c;
                    system.debug('commid--->'+ChApp.GE_PRM_Commercial_Manager__c);
                    master2.GE_PRM_Commercial_Manager1__c=ChApp.GE_PRM_Commercial_Manager__c;
                    master2.GE_PRM_Tier_2__c=ChApp.GE_PRM_Tier_2_P_L__c;
                    master2.GE_PRM_Region__c=ChApp.GE_PRM_O_G_Region__c;
                    master2.StartDate =Date.today();
                    master2.status = 'Executed';
                    master2.GE_PRM_For_Cause__c = 'Upon Notice';
                    master2.GE_PRM_Without_Cause__c = '30 days';
                    master2.GE_Contract_Specialist__c = chnlMangr.ID; 
                    master2.GE_PRM_Contract_Draft_date__c =Date.today();
                    master2.GE_PRM_Contract_Sent_to_CP__c =Date.today();
                    master2.GE_PRM_ASC_Signed_contract_received__c =Date.today();
                    master2.GE_PRM_GE_Signatures_completed__c =Date.today();
                    master2.GE_PRM_Close_out__c =Date.today();
                    master2.Hold_Flag__c = FALSE;                    
                    contractstoinsert.add(master2);
         Contract  addedum1 = new  Contract();
                    addedum1.GE_PRM_Commercial_line__c = commline.Id;
                    addedum1.GE_PRM_Channel_Appointment_ID__c=ChApp.GE_PRM_Account_Name__c;
                    addedum1.GE_Commercial_Member_Of_GE_OG__c  = ChApp.GE_PRM_Account_Name__c;
                    addedum1.GE_PRM_Commercial_Account__c = ChApp.GE_PRM_Account_Name__c;                    
                    addedum1.RecordTypeId= Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
                    addedum1.AccountID=ChApp.GE_PRM_Account_Name__c;
                    addedum1.GE_ES_User_Lead_Sales_Person__c =commline.GE_PRM_Sales_Manager__c;
                    addedum1.GE_PRM_Business_Tier_1__c = commline.GE_PRM_Tier_1__c;
                    addedum1.GE_PRM_Tier_2__c =commline.GE_PRM_Tier_2__c;
                    addedum1.GE_PRM_Tier_3__c= commline.GE_PRM_Tier_3__c;
                    addedum1.GE_PRM_Tier_4__c =commline.GE_PRM_Tier_4__c;
                    addedum1.GE_PRM_Tier_5__c= commline.GE_PRM_Tier_5__c;
                    addedum1.GE_PRM_If_flat_Pricing__c= commline.GE_PRM_If_flat_Pricing__c;
                    addedum1.GE_PRM_If_schedule_Max_Pricing__c= commline.GE_PRM_If_schedule_Max_Pricing__c;
                    addedum1.GE_PRM_If_schedule_Min_Pricing__c= commline.GE_PRM_If_schedule_Min_Pricing__c;
                    addedum1.GE_PRM_Industries__c= commline.GE_PRM_Industries__c;
                    addedum1.GE_PRM_Buyers__c= commline.GE_PRM_Buyers__c;
                    addedum1.GE_PRM_Channel_Appointment_ID__c=commline.GE_PRM_Channel_Appointment__r.id;
                    addedum1.GE_PRM_Authorized_Country__c =commline.GE_PRM_Authorized_Countries_1__c + ';'+ commline.GE_PRM_Authorized_Countries_2__c;
                    addedum1.GE_PRM_State_Province_Region__c =commline.GE_PRM_State_Province_Region__c;
                    addedum1.GE_PRM_Pricing__c= commline.GE_PRM_Pricing__c;
                    addedum1.GE_PRM_Pricing_type__c=commline.GE_PRM_Pricing_Type__c;
                    addedum1.GE_PRM_Nuclear_use__c=commline.GE_PRM_Nuclear_use_Add_comment__c;
                    addedum1.GE_PRM_Military_use__c =commline.GE_PRM_Military_use_Add_comment__c;
                    addedum1.GE_PRM_If_Brazil_SR_SC_core__c= commline.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_SC_Core__c;
                    addedum1.GE_PRM_If_Brazil_SR_CMPJ__c=commline.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_CMPJ__c;
                    addedum1.GE_PRM_Inclusions_exclusions__c = commline.GE_PRM_Inclusions_exclusions_Add_comment__c;
                    addedum1.GE_PRM_If_SR_sales_to_US_government__c =commline.GE_PRIf_Sales_Rep_sales_to_US_Government__c;
                    addedum1.GE_PRM_Comments__c =commline.GE_PRM_if_Yes_provide_comments_SlaesRep__c;
                    addedum1.GE_PRM_Commercial_Manager1__c=commline.GE_PRM_Channel_Appointment__r.GE_PRM_Commercial_Manager__c;
                    addedum1.GE_PRM_Relationship_Type__c=commline.GE_PRM_Type__c;
                    addedum1.StartDate =Date.today();
                    addedum1.ContractTerm = integer.valueof(commline.GE_PRM_Term__c);                                    
                    addedum1.GE_PRM_Primary_Sales_Channel_Manager__c =commline.GE_PRM_Channel_Appointment__r.GE_PRM_Primary_Sales_Channel_Manager__c;
                    addedum1.GE_PRM_Region__c =commline.GE_PRM_Channel_Appointment__r.GE_PRM_O_G_Region__c;
                    addedum1.status = 'Executed';                    
                    addedum1.GE_PRM_For_Cause__c = 'Upon Notice';
                    addedum1.GE_PRM_Without_Cause__c = '30 Days';
                    addedum1.GE_Contract_Specialist__c = chnlMangr.ID; 
                    addedum1.CurrencyIsoCode ='USD';
                    addedum1.GE_PRM_Governing_Law__c ='State of New York';
                    addedum1.GE_OG_Legal_Entity__c = 'ALGESCO SPA';
                    addedum1.GE_PRM_Contract_Draft_date__c = Date.today();
                    addedum1.Hold_Flag__c = FALSE; 
                    addedum1.Red_Line__c = FALSE;
                    addedum1.GE_PRM_Arbitration_location__c = 'New York, New York';
                    addedum1.GE_OG_Contract_End_Date__c = Date.today();
                    addedum1.GE_PRM_Contract_Draft_date__c = Date.today();
                    addedum1.GE_PRM_ASC_Signed_contract_received__c = Date.today();
                    addedum1.GE_PRM_GE_Signatures_completed__c = Date.today();
                    addedum1.GE_PRM_ASC_Signed_contarct_received__c = Date.today();
                    addedum1.GE_PRM_Contract_Sent_to_CP__c =Date.today();
                    addedum1.GE_PRM_Close_out__c =Date.today();
                    contractstoinsert.add(addedum1);  
          Contract  addedum2 = new  Contract();
                    addedum2.GE_PRM_Commercial_line__c = commline.Id;
                    addedum2.GE_Commercial_Member_Of_GE_OG__c  = acc1.Id;
                    addedum2.GE_PRM_Commercial_Account__c = acc1.Id;                    
                    addedum2.RecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
                    addedum2.AccountID=ChApp.GE_PRM_Account_Name__c;
                    addedum2.GE_ES_User_Lead_Sales_Person__c =commline.GE_PRM_Sales_Manager__c;
                    addedum2.GE_PRM_Business_Tier_1__c = commline.GE_PRM_Tier_1__c;
                    addedum2.GE_PRM_Tier_2__c =commline.GE_PRM_Tier_2__c;
                    addedum2.GE_PRM_Tier_3__c= commline.GE_PRM_Tier_3__c;
                    addedum2.GE_PRM_Tier_4__c =commline.GE_PRM_Tier_4__c;
                    addedum2.GE_PRM_Tier_5__c= commline.GE_PRM_Tier_5__c;
                    addedum2.GE_PRM_If_flat_Pricing__c= commline.GE_PRM_If_flat_Pricing__c;
                    addedum2.GE_PRM_If_schedule_Max_Pricing__c= commline.GE_PRM_If_schedule_Max_Pricing__c;
                    addedum2.GE_PRM_If_schedule_Min_Pricing__c= commline.GE_PRM_If_schedule_Min_Pricing__c;
                    addedum2.GE_PRM_Industries__c= commline.GE_PRM_Industries__c;
                    addedum2.GE_PRM_Buyers__c= commline.GE_PRM_Buyers__c;
                    addedum2.GE_PRM_Channel_Appointment_ID__c=commline.GE_PRM_Channel_Appointment__r.id;
                    addedum2.GE_PRM_Authorized_Country__c =commline.GE_PRM_Authorized_Countries_1__c + ';'+ commline.GE_PRM_Authorized_Countries_2__c;
                    addedum2.GE_PRM_State_Province_Region__c =commline.GE_PRM_State_Province_Region__c;
                    addedum2.GE_PRM_Pricing__c= commline.GE_PRM_Pricing__c;
                    addedum2.GE_PRM_Pricing_type__c=commline.GE_PRM_Pricing_Type__c;
                    addedum2.GE_PRM_Nuclear_use__c=commline.GE_PRM_Nuclear_use_Add_comment__c;
                    addedum2.GE_PRM_Military_use__c =commline.GE_PRM_Military_use_Add_comment__c;
                    addedum2.GE_PRM_If_Brazil_SR_SC_core__c= commline.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_SC_Core__c;
                    addedum2.GE_PRM_If_Brazil_SR_CMPJ__c=commline.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_CMPJ__c;
                    addedum2.GE_PRM_Inclusions_exclusions__c = commline.GE_PRM_Inclusions_exclusions_Add_comment__c;
                    addedum2.GE_PRM_If_SR_sales_to_US_government__c =commline.GE_PRIf_Sales_Rep_sales_to_US_Government__c;
                    addedum2.GE_PRM_Comments__c =commline.GE_PRM_if_Yes_provide_comments_SlaesRep__c;
                    addedum2.GE_PRM_Commercial_Manager1__c=commline.GE_PRM_Channel_Appointment__r.GE_PRM_Commercial_Manager__c;
                    addedum2.GE_PRM_Relationship_Type__c=commline.GE_PRM_Type__c;
                    addedum2.StartDate =Date.today();
                    addedum2.ContractTerm = integer.valueof(commline.GE_PRM_Term__c);                                    
                    addedum2.GE_PRM_Primary_Sales_Channel_Manager__c =commline.GE_PRM_Channel_Appointment__r.GE_PRM_Primary_Sales_Channel_Manager__c;
                    addedum2.GE_PRM_Region__c =commline.GE_PRM_Channel_Appointment__r.GE_PRM_O_G_Region__c;
                    addedum2.status = 'Terminated';                    
                    addedum2.GE_OG_Contract_End_Date__c = Date.today();
                    addedum2.Termination_Email__c=true;
                    addedum2.MCL_Contract__c = true;                                      
                    contractstoinsert.add(addedum2);  
               insert contractstoinsert;     
Test.stopTest();
           
     } */
     
      public static testMethod void testNewPRMContracts1()
     {
          Id adendumdRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Addendum').getRecordTypeId();
          Id ammendRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Amendment').getRecordTypeId();
          Id masterRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Master Agreement').getRecordTypeId();
    
        account accCountryHQ = new account();
        accCountryHQ.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        accCountryHQ.name = 'Test Account OLD HQ';
        accCountryHQ.Account_Tier_GEOG__c = 'Global';
        accCountryHQ.Country_GEOG__c = 'INDIA';
        accCountryHQ.Classification__c= 'Unclassified';
        accCountryHQ.Type = 'Direct Customer';
        accCountryHQ.ShippingCountry = 'India';
        //accCountry.Member_of_GE_OG__c = acc.Id;
        //accCountry.ParentId = accRegional.Id;
        insert accCountryHQ;
    
       account accCountry = new account();
        accCountry.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        accCountry.name = 'Test Account old country';
        accCountry.Account_Tier_GEOG__c = 'Country';
        accCountry.Country_GEOG__c = 'INDIA';
        accCountry.Classification__c= 'Unclassified';
        accCountry.Type = 'Direct Customer';
        accCountry.ShippingCountry = 'India';
        accCountry.Member_of_GE_OG__c = accCountryHQ.Id;
        //accCountry.ParentId = accRegional.Id;
        insert accCountry;
        
         account accLE = new account();
        accLE.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        accLE.name = 'Test Account LE';
        accLE.Account_Tier_GEOG__c = 'LE';
        accLE.Oil_Gas_Parent_Account__c = accCountry.Id;
        accLE.Country_GEOG__c = 'INDIA';
        accLE.Type = 'Direct Customer';
        accLE.Classification__c = 'Do Not Contact';
        accLE.ShippingCountry = 'India';
        accLE.Account_Status__c = 'CC Approved';
        //accLE.Member_of_GE_OG__c = acc.Id;
        insert accLE;
        
        Contract conMaster =  new Contract();
        conMaster.RecordTypeId = masterRecordTypeId;
        conMaster.AccountId = accLE.Id;
        conMaster.GE_Commercial_Member_Of_GE_OG__c = accCountryHQ.Id;
        conMaster.GE_PRM_Commercial_Account__c = accCountry.Id;
        conMaster.Status = 'Generate Draft';
        conMaster.ContractTerm = 12;
        conMaster.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
        conMaster.GE_PRM_Contract_Draft_date__c = System.today();
        conMaster.GE_PRM_GE_Confirmed_Date__c = System.today();
        conMaster.GE_PRM_Contract_Sent_to_CP__c = System.today();
        conMaster.GE_PRM_GE_Signatures_completed__c = System.today();
        conMaster.GE_PRM_ASC_Signed_contract_received__c = System.today();
        conMaster.GE_PRM_Close_out__c = System.today();
        
        insert conMaster;
        
        Contract conadd =  new Contract();
        conadd.RecordTypeId = adendumdRecordTypeId;
        conadd.AccountId = accLE.Id;
        conadd.GE_Commercial_Member_Of_GE_OG__c = accCountryHQ.Id;
        conadd.GE_PRM_Commercial_Account__c = accCountry.Id;
        conadd.Status = 'Generate Draft';
        conadd.GE_ES_User_Lead_Sales_Person__c = Userinfo.getUserId();
        conadd.PRM_Master_Agreement__c = conMaster.Id;
        conadd.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
        conadd.GE_PRM_Contract_Draft_date__c = System.today();
        conadd.GE_PRM_GE_Confirmed_Date__c = System.today();
        conadd.GE_PRM_Contract_Sent_to_CP__c = System.today();
        conadd.GE_PRM_GE_Signatures_completed__c = System.today();
        conadd.GE_PRM_ASC_Signed_contract_received__c = System.today();
        conadd.GE_PRM_Close_out__c = System.today();
        conadd.ContractTerm = 12;
        insert conadd;
        List<Contract> conlist1 = new List<Contract>();
        conlist1.add(conadd);
        List<Id> accID = new List<Id>();
        accId.add(accCountryHQ.Id);
        
        GE_PRM_Contract_Trigger_Handler.handlePRMExecutedContracts(conlist1,accId);
        
        Contract conadd2 =  new Contract();
        conadd2.RecordTypeId = adendumdRecordTypeId;
        conadd2.AccountId = accLE.Id;
        conadd2.GE_Commercial_Member_Of_GE_OG__c = accCountryHQ.Id;
        conadd2.GE_PRM_Commercial_Account__c = accCountry.Id;
        conadd2.Status = 'Generate Draft';
        conadd2.GE_ES_User_Lead_Sales_Person__c = Userinfo.getUserId();
        conadd2.PRM_Master_Agreement__c = conMaster.Id;
        conadd2.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
        conadd2.GE_PRM_Contract_Draft_date__c = System.today();
        conadd2.GE_PRM_GE_Confirmed_Date__c = System.today();
        conadd2.GE_PRM_Contract_Sent_to_CP__c = System.today();
        conadd2.GE_PRM_GE_Signatures_completed__c = System.today();
        conadd2.GE_PRM_ASC_Signed_contract_received__c = System.today();
        conadd2.GE_PRM_Close_out__c = System.today();
        conadd2.ContractTerm = 12;
        insert conadd2;
        
        conadd.Status = 'Archived';
        update conadd;
        
        List<Contract> conlist2 = new List<Contract>();
        conlist2.add(conadd2);
        //List<Id> accID = new List<Id>();
        //accId.add(accCountryHQ.Id);
        
        
        GE_PRM_Contract_Trigger_Handler.handlePRMExecutedContracts(conlist2,accId);
        
        
        
     }
     
      public static testMethod void testNewPRMContracts2()
     {
          Id adendumdRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Addendum').getRecordTypeId();
          Id ammendRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Amendment').getRecordTypeId();
          Id masterRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Master Agreement').getRecordTypeId();
    
        account accCountryHQ = new account();
        accCountryHQ.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        accCountryHQ.name = 'Test Account OLD HQ';
        accCountryHQ.Account_Tier_GEOG__c = 'Global';
        accCountryHQ.Country_GEOG__c = 'INDIA';
        accCountryHQ.Classification__c= 'Unclassified';
        accCountryHQ.Type = 'Direct Customer';
        accCountryHQ.ShippingCountry = 'India';
        //accCountry.Member_of_GE_OG__c = acc.Id;
        //accCountry.ParentId = accRegional.Id;
        insert accCountryHQ;
    
       account accCountry = new account();
        accCountry.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        accCountry.name = 'Test Account old country';
        accCountry.Account_Tier_GEOG__c = 'Country';
        accCountry.Country_GEOG__c = 'INDIA';
        accCountry.Classification__c= 'Unclassified';
        accCountry.Type = 'Direct Customer';
        accCountry.ShippingCountry = 'India';
        accCountry.Member_of_GE_OG__c = accCountryHQ.Id;
        //accCountry.ParentId = accRegional.Id;
        insert accCountry;
        
         account accLE = new account();
        accLE.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        accLE.name = 'Test Account LE';
        accLE.Account_Tier_GEOG__c = 'LE';
        accLE.Oil_Gas_Parent_Account__c = accCountry.Id;
        accLE.Country_GEOG__c = 'INDIA';
        accLE.Type = 'Direct Customer';
        accLE.Classification__c = 'Do Not Contact';
        accLE.ShippingCountry = 'India';
        accLE.Account_Status__c = 'CC Approved';
        //accLE.Member_of_GE_OG__c = acc.Id;
        insert accLE;
        
        Contract conMaster =  new Contract();
        conMaster.RecordTypeId = masterRecordTypeId;
        conMaster.AccountId = accLE.Id;
        conMaster.GE_Commercial_Member_Of_GE_OG__c = accCountryHQ.Id;
        conMaster.GE_PRM_Commercial_Account__c = accCountry.Id;
        conMaster.Status = 'Generate Draft';
        conMaster.ContractTerm = 12;
        conMaster.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
        conMaster.GE_PRM_Contract_Draft_date__c = System.today();
        conMaster.GE_PRM_GE_Confirmed_Date__c = System.today();
        conMaster.GE_PRM_Contract_Sent_to_CP__c = System.today();
        conMaster.GE_PRM_GE_Signatures_completed__c = System.today();
        conMaster.GE_PRM_ASC_Signed_contract_received__c = System.today();
        conMaster.GE_PRM_Close_out__c = System.today();
        
        insert conMaster;
        
        Contract conadd =  new Contract();
        conadd.RecordTypeId = adendumdRecordTypeId;
        conadd.AccountId = accLE.Id;
        conadd.GE_Commercial_Member_Of_GE_OG__c = accCountryHQ.Id;
        conadd.GE_PRM_Commercial_Account__c = accCountry.Id;
        conadd.Status = 'Generate Draft';
        conadd.GE_ES_User_Lead_Sales_Person__c = Userinfo.getUserId();
        conadd.PRM_Master_Agreement__c = conMaster.Id;
        conadd.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
        conadd.GE_PRM_Contract_Draft_date__c = System.today();
        conadd.GE_PRM_GE_Confirmed_Date__c = System.today();
        conadd.GE_PRM_Contract_Sent_to_CP__c = System.today();
        conadd.GE_PRM_GE_Signatures_completed__c = System.today();
        conadd.GE_PRM_ASC_Signed_contract_received__c = System.today();
        conadd.GE_PRM_Close_out__c = System.today();
        conadd.ContractTerm = 12;
        insert conadd;
        
        
        //GE_PRM_Contract_Trigger_Handler.handlePRMExecutedContracts(conlist1,accId);
        /*
        Contract conadd2 =  new Contract();
        conadd2.RecordTypeId = adendumdRecordTypeId;
        conadd2.AccountId = accLE.Id;
        conadd2.GE_Commercial_Member_Of_GE_OG__c = accCountryHQ.Id;
        conadd2.GE_PRM_Commercial_Account__c = accCountry.Id;
        conadd2.Status = 'Generate Draft';
        conadd2.GE_ES_User_Lead_Sales_Person__c = Userinfo.getUserId();
        conadd2.PRM_Master_Agreement__c = conMaster.Id;
        conadd2.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
        conadd2.GE_PRM_Contract_Draft_date__c = System.today();
        conadd2.GE_PRM_GE_Confirmed_Date__c = System.today();
        conadd2.GE_PRM_Contract_Sent_to_CP__c = System.today();
        conadd2.GE_PRM_GE_Signatures_completed__c = System.today();
        conadd2.GE_PRM_ASC_Signed_contract_received__c = System.today();
        conadd2.GE_PRM_Close_out__c = System.today();
        conadd2.ContractTerm = 12;
        insert conadd2; */
        
       /** Contract conamnd =  new Contract();
        conamnd.RecordTypeId = ammendRecordTypeId;
        conamnd.AccountId = accLE.Id;
        conamnd.GE_Commercial_Member_Of_GE_OG__c = accCountryHQ.Id;
        conamnd.GE_PRM_Commercial_Account__c = accCountry.Id;
        conamnd.Status = 'Generate Draft';
        conamnd.GE_ES_User_Lead_Sales_Person__c = Userinfo.getUserId();
        //conamnd.PRM_Master_Agreement__c = conMaster.Id;
        conamnd.PRM_Addendum_Contract__c = conadd.Id;
        conamnd.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
        conamnd.GE_PRM_Contract_Draft_date__c = System.today();
        conamnd.GE_PRM_GE_Confirmed_Date__c = System.today();
        conamnd.GE_PRM_Contract_Sent_to_CP__c = System.today();
        conamnd.GE_PRM_GE_Signatures_completed__c = System.today();
        conamnd.GE_PRM_ASC_Signed_contract_received__c = System.today();
        conamnd.GE_PRM_Close_out__c = System.today();
        conamnd.ContractTerm = 12;
        insert conamnd;
        
        
        
        
        conamnd.Status = 'Cancelled';
        update conamnd;  **/
        
        conadd.Status = 'Cancelled';
        update conadd;
        
        //conadd2.Status = 'Cancelled';
        //update conadd2;
        try{
        conMaster.Status = 'Cancelled';
        update conMaster; 
        }
        catch(Exception ex)
        {
            System.debug(ex);
        }
        //List<Id> accID = new List<Id>();
        //accId.add(accCountryHQ.Id);
        
        
        //GE_PRM_Contract_Trigger_Handler.handlePRMExecutedContracts(conlist2,accId);
        
        
        
     }
       public static testMethod void testNewPRMContracts3()
     {
          Id adendumdRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Addendum').getRecordTypeId();
          Id ammendRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Amendment').getRecordTypeId();
          Id masterRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Master Agreement').getRecordTypeId();
    
        account accCountryHQ = new account();
        accCountryHQ.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        accCountryHQ.name = 'Test Account OLD HQ';
        accCountryHQ.Account_Tier_GEOG__c = 'Global';
        accCountryHQ.Country_GEOG__c = 'INDIA';
        accCountryHQ.Classification__c= 'Unclassified';
        accCountryHQ.Type = 'Direct Customer';
        accCountryHQ.ShippingCountry = 'India';
        //accCountry.Member_of_GE_OG__c = acc.Id;
        //accCountry.ParentId = accRegional.Id;
        insert accCountryHQ;
    
       account accCountry = new account();
        accCountry.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        accCountry.name = 'Test Account old country';
        accCountry.Account_Tier_GEOG__c = 'Country';
        accCountry.Country_GEOG__c = 'INDIA';
        accCountry.Classification__c= 'Unclassified';
        accCountry.Type = 'Direct Customer';
        accCountry.ShippingCountry = 'India';
        accCountry.Member_of_GE_OG__c = accCountryHQ.Id;
        //accCountry.ParentId = accRegional.Id;
        insert accCountry;
        
         account accLE = new account();
        accLE.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        accLE.name = 'Test Account LE';
        accLE.Account_Tier_GEOG__c = 'LE';
        accLE.Oil_Gas_Parent_Account__c = accCountry.Id;
        accLE.Country_GEOG__c = 'INDIA';
        accLE.Type = 'Direct Customer';
        accLE.Classification__c = 'Do Not Contact';
        accLE.ShippingCountry = 'India';
        accLE.Account_Status__c = 'CC Approved';
        //accLE.Member_of_GE_OG__c = acc.Id;
        insert accLE;
        
        Contract conMaster =  new Contract();
        conMaster.RecordTypeId = masterRecordTypeId;
        conMaster.AccountId = accLE.Id;
        conMaster.GE_Commercial_Member_Of_GE_OG__c = accCountryHQ.Id;
        conMaster.GE_PRM_Commercial_Account__c = accCountry.Id;
        conMaster.Status = 'Generate Draft';
        conMaster.ContractTerm = 12;
        conMaster.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
        conMaster.GE_PRM_Contract_Draft_date__c = System.today();
        conMaster.GE_PRM_GE_Confirmed_Date__c = System.today();
        conMaster.GE_PRM_Contract_Sent_to_CP__c = System.today();
        conMaster.GE_PRM_GE_Signatures_completed__c = System.today();
        conMaster.GE_PRM_ASC_Signed_contract_received__c = System.today();
        conMaster.GE_PRM_Close_out__c = System.today();
        
        insert conMaster;
        /**
        Contract conadd =  new Contract();
        conadd.RecordTypeId = adendumdRecordTypeId;
        conadd.AccountId = accLE.Id;
        conadd.GE_Commercial_Member_Of_GE_OG__c = accCountryHQ.Id;
        conadd.GE_PRM_Commercial_Account__c = accCountry.Id;
        conadd.Status = 'Generate Draft';
        conadd.GE_ES_User_Lead_Sales_Person__c = Userinfo.getUserId();
        conadd.PRM_Master_Agreement__c = conMaster.Id;
        conadd.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
        conadd.GE_PRM_Contract_Draft_date__c = System.today();
        conadd.GE_PRM_GE_Confirmed_Date__c = System.today();
        conadd.GE_PRM_Contract_Sent_to_CP__c = System.today();
        conadd.GE_PRM_GE_Signatures_completed__c = System.today();
        conadd.GE_PRM_ASC_Signed_contract_received__c = System.today();
        conadd.GE_PRM_Close_out__c = System.today();
        conadd.ContractTerm = 12;
        insert conadd; **/
        
        
        //GE_PRM_Contract_Trigger_Handler.handlePRMExecutedContracts(conlist1,accId);
        
        Contract conadd2 =  new Contract();
        conadd2.RecordTypeId = adendumdRecordTypeId;
        conadd2.AccountId = accLE.Id;
        conadd2.GE_Commercial_Member_Of_GE_OG__c = accCountryHQ.Id;
        conadd2.GE_PRM_Commercial_Account__c = accCountry.Id;
        conadd2.Status = 'Generate Draft';
        conadd2.GE_ES_User_Lead_Sales_Person__c = Userinfo.getUserId();
        conadd2.PRM_Master_Agreement__c = conMaster.Id;
        conadd2.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
        conadd2.GE_PRM_Contract_Draft_date__c = System.today();
        conadd2.GE_PRM_GE_Confirmed_Date__c = System.today();
        conadd2.GE_PRM_Contract_Sent_to_CP__c = System.today();
        conadd2.GE_PRM_GE_Signatures_completed__c = System.today();
        conadd2.GE_PRM_ASC_Signed_contract_received__c = System.today();
        conadd2.GE_PRM_Close_out__c = System.today();
        conadd2.ContractTerm = 12;
        insert conadd2;
        
        
       Contract conamnd =  new Contract();
        conamnd.RecordTypeId = ammendRecordTypeId;
        conamnd.AccountId = accLE.Id;
        conamnd.GE_Commercial_Member_Of_GE_OG__c = accCountryHQ.Id;
        conamnd.GE_PRM_Commercial_Account__c = accCountry.Id;
        conamnd.Status = 'Cancelled';
        conamnd.GE_ES_User_Lead_Sales_Person__c = Userinfo.getUserId();
        //conamnd.PRM_Master_Agreement__c = conMaster.Id;
        conamnd.PRM_Addendum_Contract__c = conadd2.Id;
        conamnd.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
        conamnd.GE_PRM_Contract_Draft_date__c = System.today();
        conamnd.GE_PRM_GE_Confirmed_Date__c = System.today();
        conamnd.GE_PRM_Contract_Sent_to_CP__c = System.today();
        conamnd.GE_PRM_GE_Signatures_completed__c = System.today();
        conamnd.GE_PRM_ASC_Signed_contract_received__c = System.today();
        conamnd.GE_PRM_Close_out__c = System.today();
        conamnd.ContractTerm = 12;
        insert conamnd;
        
        //conamnd.Status = 'Cancelled';
        //update conamnd;
        
        conadd2.Status = 'Cancelled';
        
        try
        {
            update conadd2;
        }
        
        catch(Exception ex)
        {
            system.debug(ex);
        }
        
        
        
        
        
        
        //List<Id> accID = new List<Id>();
        //accId.add(accCountryHQ.Id);
        
        
        //GE_PRM_Contract_Trigger_Handler.handlePRMExecutedContracts(conlist2,accId);
        
        
        
     } 
   
}