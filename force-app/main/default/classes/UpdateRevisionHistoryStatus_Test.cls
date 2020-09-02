@isTest
public class UpdateRevisionHistoryStatus_Test{
    public static testMethod void testopptyupdate(){     
     Account acc=CommonTestDataFactory_GE_OG.createRelationshipAccount('acc1');
     Opportunity oppty=CommonTestDataFactory_GE_OG.createOppty('oppty1',acc.id);
     
     list<Bid_RevisionCounter_History__c> bidrevlst=new list<Bid_RevisionCounter_History__c>();
     list<Id> bidrevIdlst=new list<Id>();
     Bid_RevisionCounter_History__c bid=new Bid_RevisionCounter_History__c();
     bid.Opportunity__c=oppty.id;
     bidrevlst.add(bid);
     //insert bidrevlst;
     
     Bid_RevisionCounter_History__c bid1=new Bid_RevisionCounter_History__c();
     bid1.Opportunity__c=oppty.id;
     bidrevlst.add(bid1);
     insert bidrevlst;
     
     bidrevIdlst.add(bid.id);
     bidrevIdlst.add(bid1.id);
      Test.startTest();
     UpdateRevisionHistoryStatus.statusUpdate(bidrevIdlst);
     Test.stopTest();
    }
    }