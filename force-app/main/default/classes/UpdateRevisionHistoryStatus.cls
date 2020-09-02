/*
Class/Trigger Name     : UpdateRevisionHistoryStatus
Used Where ?           : Trigger to update status of Revision History
Purpose/Overview       : Used to update status of Revision History  records . 
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-32041
Author                 : Megha G
Created Date           : 20/June/2019
Test Class Name        : 
Code Coverage          : 
*/

global class UpdateRevisionHistoryStatus {
     public static void statusUpdate(List<Id> revisionHistoryId){
     system.debug('revlst method entered');
     list<Bid_RevisionCounter_History__c> revlst=new list<Bid_RevisionCounter_History__c>();
     set<id> opptyId=new set<id>();
     Map<id,Bid_RevisionCounter_History__c> opptyusermap = new  Map<id,Bid_RevisionCounter_History__c>();
     boolean executed = false;
     revlst=[select id,Status__c,name,Opportunity__c from Bid_RevisionCounter_History__c where id IN : revisionHistoryId];
     system.debug('revlst'+revlst);
     for(Bid_RevisionCounter_History__c rh:revlst)
     {
         opptyId.add(rh.Opportunity__c);
     }
     //Opportunity opp=new Opportunity();
     list<Bid_RevisionCounter_History__c> revlst1=new list<Bid_RevisionCounter_History__c>();
     revlst1=[select id,Status__c,name,Opportunity__c,New_Bid_Sent_Date_ge_og__c,Old_Bid_Sent_Date_ge_og__c,Opportunity__r.Rev_Bid_Due_Date_Count__c,Revision_Counter__c,Rev_Bid_Start_Date__c,Created_Date__c from Bid_RevisionCounter_History__c where Opportunity__c in:opptyId order by name desc];
     system.debug('revlst1'+revlst1);
     if(revlst1.size()>1){
     for(Bid_RevisionCounter_History__c revhis:revlst1)
     {
         if(revlst1[0].Revision_Counter__c!=revlst1[1].Revision_Counter__c)
         {  
             //opp.id=revlst1[0].Opportunity__c;
             revlst1[1].Status__c='Complete';
             revlst1[0].Rev_Bid_Start_Date__c=revlst1[0].Created_Date__c;
             //opp.Rev_Bid_Due_Date_Count__c=0;
             //opp.Rev_Bid_Sent_Date_Count__c=0;
             // update opp;
         }
          else if(revhis.Status__c=='current')
         {
             revhis.Status__c=null;
             opptyusermap.put(revhis.id,revhis);
             
         }
         else if(revlst1[0].Old_Bid_Sent_Date_ge_og__c== Null &&revlst1[0].New_Bid_Sent_Date_ge_og__c==null && revlst1[0].Status__c==null )
         {
            
             revlst1[0].Status__c='CURRENT';
             system.debug('test'+revhis.Old_Bid_Sent_Date_ge_og__c);
             //executed  = true;
         }
         else
         {
             revlst1[0].Rev_Bid_Start_Date__c=revlst1[1].Created_Date__c;
         }
       
     }
     
     }
     update revlst1;
     update opptyusermap.values();
    }
    }