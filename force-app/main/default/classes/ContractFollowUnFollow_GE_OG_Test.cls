@isTest
public class ContractFollowUnFollow_GE_OG_Test{
    
    @testsetup
    static void createTestData(){
    
        //creating 'Country Region Mapping' for 'INDIA'
        Country_Region_Mapping_ge_og__c objcustom = CommonTestDataFactory_GE_OG.createCountryRegionMappingData();
        insert objcustom;
        
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','CMF Approved').getRecordTypeId();
        acc.name = 'Test LE121212';
        acc.Account_Tier_GEOG__c = 'LE';
        acc.Country_GEOG__c = 'INDIA';
        acc.Classification__c= 'Unclassified';
        acc.Type = 'Direct Customer';
        acc.ShippingCountry = 'India';
        acc.Account_Status__c = 'CC Approved';
        //acc.Oil_Gas_Parent_Account__c = accID;
        //Account accGlobal= CommonTestDataFactory_GE_OG.createAccount('TestAccount Global');    
        //acc.Member_of_GE_OG__c = accGlobal.Id;//
        insert acc;
        
        Contract objCon = new Contract();
        objCon.name = 'Test Team Contract';
        objCon.AccountId = acc.id;
        objCon.GE_OG_Evergreen__c = true;
        objCon.Status = 'Draft';
        objCon.Primary_Contract_Manager__c = UserInfo.getUserID();
        insert objCon;
    }
    
    static testMethod void updateOpportunityAsFollowUnFollow(){
        
        Test.startTest();
        
            Contract con = [Select ID, Name from Contract where Name = 'Test Team Contract' LIMIT 1];
            system.assertEquals('Test Team Contract',con.Name);
            
            Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        
            User objUser = new User(Alias = 'standt1', Email='standarduser1@testbsoft.com', 
            EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser1@testbsoft.com');
        
            insert objUser;
        
            objUser = new User(Alias = 'standt2', Email='standarduser2@testbsoft.com', 
            EmailEncodingKey='UTF-8', LastName='Testing2', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser2@testbsoft.com');
            
            insert objuser;    
            
            ID userID = UserInfo.getUserID();
            List<User> lstUser = new List<User>();
            
            lstUser = [Select ID from User where Profile.Name = 'System Administrator' and IsActive = True and ID !=: userID limit 2];
            system.assertEquals(2,lstUser.size());
    
            List<ID> lstID = new List<ID>();
            lstID.add(con.ID);
            system.assertEquals(1,lstID.size());
             
            system.runAs(lstUser[0]){
                ContractFollowUnFollow_GE_OG.updateContractAsFollow_UnFollow(lstID);
                ContractFollowUnFollow_GE_OG.updateContractAsFollow_UnFollow(lstID);
            }
            
            Contract_Team__c objTeamMember = new Contract_Team__c();
            objTeamMember.Contract_Team_Member__c = lstUser[1].ID;
            objTeamMember.Contract__C = con.ID;
            objTeamMember.Team_Role__c = 'Contracts Manager';
            insert objTeamMember;
            
            system.runAs(lstUser[1]){
                try{
                    ContractFollowUnFollow_GE_OG.updateContractAsFollow_UnFollow(lstID);
                }catch(Exception ex){}    
            }
        
        Test.stopTest();
    }
    
    static testMethod void checkContractStage(){
        
        Test.startTest();
        
        Contract con = [Select ID, Name from Contract where Name = 'Test Team Contract' LIMIT 1];
        system.assertEquals('Test Team Contract',con.Name);
        
        con.Dataload__c = true;
        con.GE_PRM_Type__c = 'Master Service Agreement';
        con.Primary_Contract_Manager__c = UserInfo.getUserID();
        con.recordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Deal Machine Contract').getRecordTypeId();
        update con;
        List<Id> contrList = new List<Id>();
        contrList.add(con.id);
        DealMachineContractStageAutomation.stageautomationDMContract(contrList);
        test.stopTest();
        /*con.recordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Deal Machine Contract').getRecordTypeId();
        con.Language_GEOG__c = 'Other';
        con.StartDate = system.today();
        update con;
        con.name = '';
        update con;
        DealMachineContractStageAutomation.stageautomationDMContract(contrList);*/
        
    }
    static testMethod void testTeamCreation(){
        //test.startTest();
        account acc = new account();
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc.name = 'Test 121212';
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Country_GEOG__c = 'INDIA';
        acc.Classification__c= 'Unclassified';
        acc.Type = 'Direct Customer';
        acc.ShippingCountry = 'India';
        //acc.Account_Status__c = 'CC Approved';
        //acc.Oil_Gas_Parent_Account__c = accID;
        //Account accGlobal= CommonTestDataFactory_GE_OG.createAccount('TestAccount Global');    
        //acc.Member_of_GE_OG__c = accGlobal.Id;//
        insert acc;
        
        account accLE = new account();
        accLE.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        accLE.name = 'Test LELE121212';
        accLE.Account_Tier_GEOG__c = 'LE';
        accLE.Country_GEOG__c = 'INDIA';
        accLE.Classification__c= 'Unclassified';
        accLE.Type = 'Direct Customer';
        acc.ShippingCountry = 'India';
        accLE.Account_Status__c = 'CC Approved';
        accLE.Oil_Gas_Parent_Account__c = acc.id;
        //Account accGlobal= CommonTestDataFactory_GE_OG.createAccount('TestAccount Global');    
        //acc.Member_of_GE_OG__c = accGlobal.Id;//
        insert accLE;
        
        //Createing an Account
        //Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccountWithMember('TestAccount Legal',acc.ID,acc1.ID);
        //system.assertEquals('TestAccount Legal',accLE.Name);
        
        //Create Test Account for ContactSumTrigger
        String TestAccountName = system.Label.Test_Account_Name;
        
        Account accInternal = CommonTestDataFactory_GE_OG.createSellingLegalEntityAccount('TestAccount Internal',acc.ID);
        system.assertEquals('TestAccount Internal',accInternal.Name);
        
        //Account competitorAccount = CommonTestDataFactory_GE_OG.createCompetitorAccount('Competitor Account');
        test.startTest();
        
        //Creating an Opportunity
        Opportunity oppty= CommonTestDataFactory_GE_OG.createOpptyOFSIWS('Testopportunity',acc.ID);
        system.assertEquals('Testopportunity',oppty.Name);
        
        Contract con = [Select ID, Name from Contract where Name = 'Test Team Contract' LIMIT 1];
        
        Opportunity_Contract_Relationship_GE_OG__c oppcon = new Opportunity_Contract_Relationship_GE_OG__c();
        oppcon.Contract_ID_GE_OG__c = con.Id;
        oppcon.Primary_Opportunity_GE_OG__c = true;
        oppcon.opportunity_ID_ge_og__c = oppty.id;
        insert oppcon;
        
        List<Id> lst = new List<Id>();
        lst.add(oppcon.id);
        DealMachineContractTeamCraetion.contractTeamDMContract(lst);
        test.stopTest();
    }
    
    public static testMethod void checkStage2(){
        test.startTest();
        Contract con1 = [Select ID, Name from Contract where Name = 'Test Team Contract' LIMIT 1];
        con1.recordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Deal Machine Contract').getRecordTypeId();
        con1.status = 'Expired';
        update con1;
        List<Id> contrList1 = new List<Id>();
        contrList1.add(con1.id);
        DealMachineContractStageAutomation.stageautomationDMContract(contrList1);
        Test.stopTest();
    }
    
    public static testMethod void creationUpdateTeam(){
        test.startTest();
        Contract con1 = [Select ID, Name from Contract where Name = 'Test Team Contract' LIMIT 1];
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        
        User objUser = new User(Alias = 'standt1', Email='standarduser1@testbsoft.com', 
        EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='standarduser1@testbsoft.com');
    
        insert objUser;
        
        Contract_Team__c objTeamMember = new Contract_Team__c();
        objTeamMember.Contract_Team_Member__c = objUser.id;
        objTeamMember.Contract__C = con1.ID;
        objTeamMember.Team_Role__c = 'Primary Contract Owner';
        insert objTeamMember;
            
        List<Id> contrList1 = new List<Id>();
        contrList1.add(con1.id);
        DealMachineContractTeamCraetion.contractTeamDMContract(contrList1);
        Test.stopTest();
    }
}