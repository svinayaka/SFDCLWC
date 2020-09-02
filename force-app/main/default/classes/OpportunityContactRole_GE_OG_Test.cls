/*
Class/Trigger Name     : OpportunityContactRole_GE_OG_Test
Used Where ?           : OpportunityContactRole_GE_OG
Purpose/Overview       : for Code Coverage of OpportunityContactRole_GE_OG
Scrum Team             : Oppty MGMT - Transformation
Requirement Number     : 
Author                 : Nitish Pandey
Created Date           : 4/JAN/2016

*/

@isTest
global  class OpportunityContactRole_GE_OG_Test{
    
    @testsetup
    static void createRecord(){
        
         //Creating new account
        Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('Test Account');
        Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
        Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccountWithMember('Test Account LE',acc.ID,acc1.ID);
        
        Contact cont = new Contact();
        cont.Lastname = 'test';
        cont.Firstname = 'Contact';
        cont.Email = 'Contact@qwe.ygf';
        cont.AccountId = accLE.id;
        insert cont;
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOppty('TestOppty', acc.id);
        
    }
    
    public static testMethod void testOpportunityContactRole(){
    
    test.startTest();
        Opportunity oppty = [select id from Opportunity where name ='TestOppty'];
        List<Id> OpptyIds = new List<Id>();
        OpptyIds.add(oppty.id);
        
        
        OpportunityContactRole_GE_OG.updateOpportunityContactRole(OpptyIds);
        
        Contact cont = [select id from contact where lastName='test'];
        
        OpportunityContactRole ocr = new OpportunityContactRole();
        ocr.opportunityId = oppty.id;
        ocr.ContactId = cont.id;
        Insert ocr;
        
         OpportunityContactRole_GE_OG.updateOpportunityContactRole(OpptyIds);
         test.stopTest();
        
    }

}