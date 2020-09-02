@isTest
public class EmailToOpptyOnContractCreation_Test{
    public static testMethod void testopptycontractEmail(){     
     
     
     Account acc=CommonTestDataFactory_GE_OG.createRelationshipAccount('acc1');
     Opportunity oppty=CommonTestDataFactory_GE_OG.createOppty('oppty1',acc.id);
     
     test.startTest();
     Contract objCon = new Contract();
        objCon.name = 'Test Team Contract';
        objCon.AccountId = acc.id;
        objCon.GE_OG_Evergreen__c = true;
        objCon.Status = 'Draft';
        insert objCon;
       test.stopTest();
        
         Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        
            User objUser = new User(Alias = 'standt1', Email='standarduser1@testbsoft.com', 
            EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser1@testbsoft.com');
        
            insert objUser;
        
     CommonTestDataFactory_GE_OG.createOpportunityTeamMember(oppty.id,objUser.id,'role');
     
     Opportunity_Contract_Relationship_GE_OG__c oppcon = new Opportunity_Contract_Relationship_GE_OG__c();
        oppcon.Contract_ID_GE_OG__c = objCon.Id;
        oppcon.Primary_Opportunity_GE_OG__c = true;
        oppcon.opportunity_ID_ge_og__c = oppty.id;
        insert oppcon;
        
         Opportunity_Contract_Relationship_GE_OG__c oppcon1 = new Opportunity_Contract_Relationship_GE_OG__c();
        oppcon1.Contract_ID_GE_OG__c = objCon.Id;
        oppcon1.Primary_Opportunity_GE_OG__c = false;
        oppcon1.opportunity_ID_ge_og__c = oppty.id;
        insert oppcon1;
        
     }
     }