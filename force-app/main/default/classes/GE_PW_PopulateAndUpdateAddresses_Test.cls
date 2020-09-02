/*    
Class Name        : GE_PW_PopulateAndUpdateAddresses_Test
Purpose/Overview  : Test class for GE_PW_PopulateAndUpdateAddresses Trigger on Account object
Author            : Malemleima Chanu
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 15 April 2013  : Malemleima Chanu     : Created : Created the test class for covering the trigger
*/
@isTest
Public Class GE_PW_PopulateAndUpdateAddresses_Test{

    Static TestMethod Void GE_PW_PopulateAndUpdateAddresses_Test(){
     
        Test.startTest();
        
        String rt = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Pending Customer Request').getRecordTypeId();
        
        Account Acc= new Account(Name='Test Acc',GE_HQ_New_Account_Street__c='wallstreet', GE_HQ_New_Account_City__c='New York',GE_HQ_New_Account_State_Province__c='Test Data',GE_HQ_New_Account_Zip_Postal_Code__c='123456',GE_PW_Phone_New_Request__c='1234567',GE_HQ_Nts_Comments__c='testing');  
        Acc.GE_PW_Street_Bill_To__c='Test Bill';
        Acc.GE_PW_City_Bill_To__c='Test City';
        Acc.RecordtypeId= rt;
        Acc.GE_PW_State_Province_Bill_To__c='Test State';
        Acc.GE_PW_Zip_Postal_Code_Bill_To__c='11111';
        Acc.GE_PW_Country_Bill_To__c='Antarctica';
        Acc.GE_PW_Latitude_Bill_To__c='+12.2345';
        Acc.GE_PW_Longitude_Bill_To__c='+12.2345';
        Acc.GE_PW_Phone_Bill_To__c='67676767';
        Acc.GE_HQ_New_Account_Country__c='ALBANIA';
        Insert Acc;
        
        Account Acc1= new Account(Name='Test Acc',GE_HQ_New_Account_Street__c='wallstreet', GE_HQ_New_Account_City__c='New York',GE_HQ_New_Account_State_Province__c='Test Data',GE_HQ_New_Account_Zip_Postal_Code__c='123456',GE_PW_Phone_New_Request__c='1234567',GE_HQ_Nts_Comments__c='testing');  
        Acc1.GE_PW_Street_Bill_To__c='Test Bill';
        Acc1.GE_PW_City_Bill_To__c='Test City';
        Acc1.GE_PW_State_Province_Bill_To__c='Test State';
        Acc.RecordtypeId=rt;        
        Acc1.GE_PW_Zip_Postal_Code_Bill_To__c='11111';
        Acc1.GE_PW_Country_Bill_To__c='Antarctica';
        Acc1.GE_PW_Latitude_Bill_To__c='+12.2345';
        Acc1.GE_PW_Longitude_Bill_To__c='+12.2345';
        Acc1.GE_PW_Phone_Bill_To__c='67676767';
        Acc1.GE_HQ_New_Account_Country__c='ALBANIA';
        Insert Acc1;
        
        Account AccObj = New Account(Name='Test Acc',GE_HQ_New_Account_Street__c='wallstreet', GE_HQ_New_Account_City__c='New York',GE_HQ_New_Account_State_Province__c=' Test Data',GE_HQ_New_Account_Zip_Postal_Code__c='123456',GE_HQ_New_Account_Country__c='AUSTRIA',GE_PW_Phone_New_Request__c='1234567',GE_HQ_Nts_Comments__c='testing');  
        AccObj.GE_PW_Existing_Customer_New_Address__c=Acc.Id;
        AccObj.GE_PW_Country_Quote_To_Sold_To_HQ__c= 'ARMENIA';
        AccObj.GE_HQ_New_Account_Country__c= 'ARMENIA';
        AccObj.RecordtypeId=rt;          
        AccObj.GE_PW_Street_Quote_To_Sold_To_HQ__c = 'Test Street';
        AccObj.GE_PW_City_Quote_To_Sold_To_HQ__c = 'test city';
        AccObj.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='Test Province';
        AccObj.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c= '1213242343';
        AccObj.GE_PW_Latitude_Quote_To_Sold_To_HQ__c='+12.2345';
        AccObj.GE_PW_Longitude_Quote_To_Sold_To_HQ__c='+12.2345';
        AccObj.GE_PW_Phone_Quote_To_Sold_To_HQ__c='67676767';
        AccObj.GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c = false;
        AccObj.GE_PW_Send_to_CMF_Bill_To__c= false;
        Insert AccObj;
        
        AccObj.GE_PW_Existing_Customer_New_Address__c=Acc1.Id;
        AccObj.GE_PW_Country_Quote_To_Sold_To_HQ__c= 'AUSTRIA';
        AccObj.GE_PW_Street_Quote_To_Sold_To_HQ__c = 'ring road';
        AccObj.GE_PW_City_Quote_To_Sold_To_HQ__c = 'new delhi';
        AccObj.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='delhi';
        AccObj.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c= '5000003';
        AccObj.GE_PW_Latitude_Quote_To_Sold_To_HQ__c='+22.2345';
        AccObj.GE_PW_Longitude_Quote_To_Sold_To_HQ__c='+22.2345';
        AccObj.GE_PW_Phone_Quote_To_Sold_To_HQ__c='88676767';
        AccObj.GE_HQ_New_Account_Country__c='AUSTRIA';
        AccObj.GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c = true;
        AccObj.GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c = true;
        AccObj.GE_PW_DB_DUNS_QuoteTo__c = '123456789';
        Update AccObj;
        
        AccObj.GE_PW_Send_to_CMF_Bill_To__c=True;
        Update AccObj;
        Test.stopTest();
        
        GE_PW_CMFtoISOCountryName__c Obj1 =new GE_PW_CMFtoISOCountryName__c();
        Obj1.Name= 'a3zA0000000DRq2';
        Obj1.GE_PW_CMF_Name__c='AUSTRIA';
        Obj1.GE_PW_ISO_Code__c ='AT';
        Insert Obj1;
        
   
        /*String at = Schema.SObjectType.Account.getRecordTypeInfosByName().get('New Customer Request - Step 2').getRecordTypeId();
        Account Acc2 =  New Account(Name='Test Acc',GE_HQ_New_Account_Street__c='wallstreet', GE_HQ_New_Account_City__c='New York',GE_HQ_New_Account_State_Province__c=' Test Data',GE_HQ_New_Account_Zip_Postal_Code__c='123456',GE_HQ_New_Account_Country__c='CANADA',GE_PW_Phone_New_Request__c='1234567',GE_HQ_Nts_Comments__c='testing');
        Acc2.RecordtypeId=at;
        Insert Acc2;
        
        Acc2.GE_PW_Street_Quote_To_Sold_To_HQ__c = 'wallstreet';
        Acc2.GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c = False;
        Acc2.GE_PW_Street_Bill_To__c = 'test street';
        Acc2.GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c = False;
        Acc2.GE_PW_Street_Ship_To__c = 'test street';
        Update Acc2;*/
    }         
}