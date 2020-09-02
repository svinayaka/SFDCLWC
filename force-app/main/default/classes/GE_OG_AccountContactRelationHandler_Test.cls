/*
Class/Trigger Name     : GE_OG_AccountContactRelationHandler_Test
Used Where ?           : GE_OG_AccountContactRelationTrigger,GE_OG_AccountContactRelationHandler(Class),SetContactPrimaryFlag(Trigger) 
Purpose/Overview       : for Code Coverage of GE_OG_AccountContactRelationTrigger,GE_OG_AccountContactRelationHandler(Class),SetContactPrimaryFlag(Trigger)
Scrum Team             : Accounts & Contacts Scrum
Requirement Number     : R-24326
Author                 : Niranjana
Created Date           : 14/NOV/2016
*/

@isTest 
private class GE_OG_AccountContactRelationHandler_Test{
    static testMethod void SetPrimaryFlagOnInsert() {
    List<Account> newAccnts = new List<Account>();
    RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='Relationship Account' Limit 1];    
         Account acnt = new Account();
         acnt.Name='Test Account DQ';
         acnt.RecordTypeId = rt.Id;
         acnt.Type = 'EPC';
         acnt.Classification__c = 'Strategic';
         acnt.GE_ES_Primary_Industry__c = 'Drilling';
         acnt.Compliance_Ready__c = True; 
         
        //Account acnt =AccountTestDataFactory.createAcctWithStrength('Test Account DQ','Medium',True);
         
         newAccnts.add(acnt);
         
         Account acnt2 = new Account();
         acnt2.Name='Test Account DQ2';
         acnt2.RecordTypeId = rt.Id;
         acnt2.Type = 'EPC';
         acnt2.Classification__c = 'Strategic';
         acnt2.GE_ES_Primary_Industry__c = 'Drilling';
         acnt2.Compliance_Ready__c = True;
         
         //Account acnt2 =AccountTestDataFactory.createAcctWithStrength('Test Account DQ2','Medium',True);
         newAccnts.add(acnt2);
         
         insert newAccnts;
         
     
         /*Contact cont = new Contact();
         cont.LastName = 'Test';
         cont.FirstName = 'Primary Contact';
         cont.Phone = '98745632145';
         cont.Email = 'test@test.com';
         cont.GE_PRM_Primary_Contact__c = True;
         cont.AccountId = newAccnts[0].Id;
         insert cont;*/
         
         
         Contact cont = AccountTestDataFactory.createPrimaryContact(acnt.id,'Primary Contact','Test',true);
         
         
         
         
        /* Contact cont2 = new Contact();
         cont2.LastName = 'Test';
         cont2.FirstName = 'Primary Contact1';
         cont2.Phone = '98745632146';
         cont2.Email = 'test2@test.com';
         cont2.GE_PRM_Primary_Contact__c = True;
         cont2.AccountId = newAccnts[1].Id;
         insert cont2;*/
         
         Contact cont2 = AccountTestDataFactory.createPrimaryContact(acnt2.id,'Primary Contact1','Test',true);
         
         Account AccList= [Select id,name from account where id IN: newAccnts and name='Test Account DQ' limit 1]; 
         Contact ConList= [Select id,name from contact where id =: cont2.id and FirstName='Primary Contact1' limit 1];   
          
         Test.startTest();
         
         AccountContactRelation accContRel=[Select id,ContactId,AccountId,GE_OG_Primary_Contact__c from AccountContactRelation where contactId=:cont.id and AccountId=:newAccnts[0].Id];
          accContRel.GE_OG_Primary_Contact__c=true;
          GE_OG_AccountContactRelationHandler.isFirstTime = true;
         update accContRel;
         
         AccountContactRelation accCont=new AccountContactRelation();
          accCont.ContactId= ConList.id;
          accCont.AccountId= AccList.Id;
          accCont.GE_OG_Primary_Contact__c= true;
          GE_OG_AccountContactRelationHandler.isFirstTime = true;
         insert accCont;
                   
         AccountContactRelation getRelatedContactToDelete = [Select id,isDirect,contactid,accountid,GE_OG_Primary_Contact__c from AccountContactRelation where account.name='Test Account DQ' and isDirect=false and GE_OG_Primary_Contact__c=true limit 1];
         delete getRelatedContactToDelete;
          
         Test.stopTest();
                  
     }
}