@isTest
public class LEReparenting_Test{
     @testSetup
     static void createTestData(){
        account accCountry = new account();
        accCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accCountry.name = 'Test Account Country';
        accCountry.Account_Tier_GEOG__c = 'Country';
        accCountry.Country_GEOG__c = 'INDIA';
        accCountry.Classification__c= 'Unclassified';
        accCountry.Type = 'Direct Customer';
        accCountry.ShippingCountry = 'India';
        //accCountry.Member_of_GE_OG__c = acc.Id;
        //accCountry.ParentId = accRegional.Id;
        insert accCountry;
        
        account accCountryNew = new account();
        accCountryNew.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accCountryNew.name = 'Test Account Country New';
        accCountryNew.Account_Tier_GEOG__c = 'Country';
        accCountryNew.Country_GEOG__c = 'INDIA';
        accCountryNew.Classification__c= 'Unclassified';
        accCountryNew.Type = 'Direct Customer';
        accCountryNew.ShippingCountry = 'India';
        //accCountryNew.Member_of_GE_OG__c = acc.Id;
        //accCountryNew.ParentId = accRegional.Id;
        insert accCountryNew;
        
        /*List<Account> lstCountries = new List<Account>();
        lstCountries.add(accCountry);
        lstCountries.add(accCountryNew);
        insert lstCountries;*/
        
        account accLE = new account();
        accLE.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','CMF Approved').getRecordTypeId();
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
        
        Re_Parenting_LE_Request__c req = new Re_Parenting_LE_Request__c();
        req.Request_Status__c = 'Pending';
        req.Legal_Entity__c = accLE.id;
        req.Old_Parent_Account__c = accCountry.id;
        req.New_Parent_Account__c = accCountryNew.id;
        insert req;
        
     }
     
     public static testMethod void testReparent_Accounts(){
        test.startTest();
        Account accLE = [SELECT Id, name, RecordTypeId,Account_Status__c,Oil_Gas_Parent_Account__c FROM Account
                        WHERE name='Test Account LE' LIMIT 1];
        account accCountryNew = new account();
        accCountryNew.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accCountryNew.name = 'Test Account Country New12';
        accCountryNew.Account_Tier_GEOG__c = 'Country';
        accCountryNew.Country_GEOG__c = 'INDIA';
        accCountryNew.Classification__c= 'Unclassified';
        accCountryNew.Type = 'Direct Customer';
        accCountryNew.ShippingCountry = 'India';
        //accCountryNew.Member_of_GE_OG__c = acc.Id;
        //accCountryNew.ParentId = accRegional.Id;
        insert accCountryNew;
        
        Re_Parenting_LE_Request__c req = [SELECT Id,name,Request_Status__c, Legal_Entity__c,Old_Parent_Account__c,New_Parent_Account__c
                                            FROM Re_Parenting_LE_Request__c where Legal_Entity__c=: accLE.id LIMIT 1];
        LEReParentingController.LeReparentParser parser = new LEReParentingController.LeReparentParser();
        parser.legalEntId = accLE.id;
        parser.requestId = req.id;
        parser.newParentId = accCountryNew.id;
        List<LEReParentingController.LeReparentParser> lstParse = new List<LEReParentingController.LeReparentParser>();
        lstParse.add(parser);
        LEReParentingController.reparent(lstParse);
        test.stopTest();
    }
    
    public static testMethod void testReparent_AccountsContacts(){
        test.startTest();
        Account objLE = [SELECT Id, name, RecordTypeId,Account_Status__c,Oil_Gas_Parent_Account__c FROM Account
                        WHERE name='Test Account LE' LIMIT 1];
        /*Account objOldCountry = [SELECT Id, name, RecordTypeId FROM Account
        WHERE name='Test Account Country' LIMIT 1];*/
        
        account objnewcountry= new account();
        objnewcountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        objnewcountry.name = 'Test Account Country New123';
        objnewcountry.Account_Tier_GEOG__c = 'Country';
        objnewcountry.Country_GEOG__c = 'INDIA';
        objnewcountry.Classification__c= 'Unclassified';
        objnewcountry.Type = 'Direct Customer';
        objnewcountry.ShippingCountry = 'India';
        //accCountryNew.Member_of_GE_OG__c = acc.Id;
        //accCountryNew.ParentId = accRegional.Id;
        insert objnewcountry;
        
        Re_Parenting_LE_Request__c req = [SELECT Id,name,Request_Status__c, Legal_Entity__c,Old_Parent_Account__c,New_Parent_Account__c
                                            FROM Re_Parenting_LE_Request__c where Legal_Entity__c=: objLE.id LIMIT 1];
        Contact objCon = new Contact();
        objCon.AccountId =objLE.Oil_Gas_Parent_Account__c;
        objCon.GE_OG_Site_LegalEntity_Account__c = objLE.id;
        objCon.FirstName = 'Reparent'; 
        objCon.LastName= 'Contact'; 
        objCon.Email = 'reparent@le.com';
        insert objCon;
        
        LEReParentingController.LeReparentParser parser = new LEReParentingController.LeReparentParser();
        parser.legalEntId = objLE.id;
        parser.requestId = req.id;
        parser.newParentId = objnewcountry.id;
        List<LEReParentingController.LeReparentParser> lstParse = new List<LEReParentingController.LeReparentParser>();
        lstParse.add(parser);
        LEReParentingController.reparent(lstParse);
        
        //To cover finish() in Batch class
        List<SObject> lstRelated = new List<SObject>();
        lstRelated.add(objCon);
        BatchLEReparentRecordsController objBatch = new BatchLEReparentRecordsController(req.id,lstRelated);
        Map<Id,String> mapErrors = new Map<Id,String>();
        mapErrors.put(objCon.id, 'Error Occured');
        objBatch.errorMap =mapErrors;
        DataBase.executeBatch(objBatch);
        test.stopTest();
    }
    public static testMethod void testReparent_AccountsContracts_Region(){
        test.startTest();
        Account objLE = [SELECT Id, name, RecordTypeId,Account_Status__c,Oil_Gas_Parent_Account__c FROM Account
                        WHERE name='Test Account LE' LIMIT 1];
                        
        account objReg = new account();
        objReg.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        objReg.name = 'Test Account Region';
        objReg.Account_Tier_GEOG__c = 'Regional';
        objReg.Classification__c= 'Unclassified';
        objReg.Type = 'Direct Customer';
        objReg.ShippingCountry = 'India';
        insert objReg;
        
        account objnewcountry= new account();
        objnewcountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        objnewcountry.name = 'Test Account Country New123';
        objnewcountry.Account_Tier_GEOG__c = 'Country';
        objnewcountry.Country_GEOG__c = 'INDIA';
        objnewcountry.Classification__c= 'Unclassified';
        objnewcountry.Type = 'Direct Customer';
        objnewcountry.ShippingCountry = 'India';
        //accCountryNew.Member_of_GE_OG__c = acc.Id;
        //accCountryNew.ParentId = accRegional.Id;
        insert objnewcountry;
        
        
        Contact objCon = new Contact();
        objCon.AccountId =objReg.id;
        objCon.GE_OG_Site_LegalEntity_Account__c = objLE.id;
        objCon.FirstName = 'Reparent'; 
        objCon.LastName= 'Contact'; 
        objCon.Email = 'reparent@le.com';
        insert objCon;
        
        List<Contact> lstCon = new List<Contact>();
        lstCon.add(objCon);
        
        Accounts_ContactsReparentHandler.reparentContacts(lstCon,objnewcountry);
        test.stopTest();
    }
    
    public static testMethod void testReparent_AccountsContacts_Region(){
        test.startTest();
        Account objLE = [SELECT Id, name, RecordTypeId,Account_Status__c,Oil_Gas_Parent_Account__c FROM Account
                        WHERE name='Test Account LE' LIMIT 1];
                        
                
        account objnewcountry= new account();
        objnewcountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        objnewcountry.name = 'Test Account Country New123';
        objnewcountry.Account_Tier_GEOG__c = 'Country';
        objnewcountry.Country_GEOG__c = 'INDIA';
        objnewcountry.Classification__c= 'Unclassified';
        objnewcountry.Type = 'Direct Customer';
        objnewcountry.ShippingCountry = 'India';
        //accCountryNew.Member_of_GE_OG__c = acc.Id;
        //accCountryNew.ParentId = accRegional.Id;
        insert objnewcountry;
        
        
        Contract objCon = new Contract();
        objCon.AccountId =objLE.id;
        objCon.Commercial_Account_Name_GEOG__c =objLE.Oil_Gas_Parent_Account__c;
        objCon.Status= 'Draft';
        //objCon.recordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Deal_Machine_Contract').getRecordTypeId();
        objCon.Is_Created_From_DM__c = TRUE;
        insert objCon;
        
        List<Contract> lstCon = [SELECT id, name,Status,Commercial_Account_Name_GEOG__c ,Commercial_Account_Name_GEOG__r.Account_Tier_GEOG__c
                                FROM Contract
                                WHERE Commercial_Account_Name_GEOG__c =: objLE.Oil_Gas_Parent_Account__c LIMIT 1];
        Accounts_ContactsReparentHandler.reparentDM_Contracts(lstCon,objnewcountry);
        Accounts_ContactsReparentHandler.reparentExe_Contracts(lstCon,objnewcountry);
        Accounts_ContactsReparentHandler.reparentFrameAgr_Contracts(lstCon,objnewcountry);
        test.stopTest();
    }
    
    public static testMethod void testReparent_AccountsContracts_Region12(){
        test.startTest();
        Account objLE = [SELECT Id, name, RecordTypeId,Account_Status__c,Oil_Gas_Parent_Account__c FROM Account
                        WHERE name='Test Account LE' LIMIT 1];
                        
                
        account objnewcountry= new account();
        objnewcountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        objnewcountry.name = 'Test Account Country New123';
        objnewcountry.Account_Tier_GEOG__c = 'Country';
        objnewcountry.Country_GEOG__c = 'INDIA';
        objnewcountry.Classification__c= 'Unclassified';
        objnewcountry.Type = 'Direct Customer';
        objnewcountry.ShippingCountry = 'India';
        //accCountryNew.Member_of_GE_OG__c = acc.Id;
        //accCountryNew.ParentId = accRegional.Id;
        insert objnewcountry;
        
        account reg= new account();
        reg.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        reg.name = 'Test Account Regional New123';
        reg.Account_Tier_GEOG__c = 'Regional';
        reg.Country_GEOG__c = 'INDIA';
        reg.Classification__c= 'Unclassified';
        reg.Type = 'Direct Customer';
        reg.ShippingCountry = 'India';
        //reg.Member_of_GE_OG__c = acc.Id;
        //reg.ParentId = accRegional.Id;
        insert reg;
        
        
        Contract objCon = new Contract();
        objCon.AccountId =objLE.id;
        objCon.Commercial_Account_Name_GEOG__c =reg.id;
        //objCon.Commercial_Account_Name_GEOG__r.Account_Tier_GEOG__c ='Regional';
        objCon.Status= 'Draft';
        //objCon.recordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Deal_Machine_Contract').getRecordTypeId();
        objCon.Is_Created_From_DM__c = TRUE;
        insert objCon;
        
        List<Contract> lstCon = [SELECT id, name,Status,Commercial_Account_Name_GEOG__c ,Commercial_Account_Name_GEOG__r.Account_Tier_GEOG__c
                                FROM Contract
                                WHERE Commercial_Account_Name_GEOG__c =: reg.id LIMIT 1];
        //lstCon.add(objCon);
        
        Accounts_ContactsReparentHandler.reparentDM_Contracts(lstCon,objnewcountry);
        Accounts_ContactsReparentHandler.reparentExe_Contracts(lstCon,objnewcountry);
        test.stopTest();
    }
}