trigger UpdateRevisionHistory on Bid_RevisionCounter_History__c (after insert) {
     List<Id>  revhistID=new List<Id>();
      
       if(Trigger.IsInsert && trigger.isAfter ) {
      for(Bid_RevisionCounter_History__c opRec: Trigger.new){
       revhistID.add(opRec.id);
   }
   }
   UpdateRevisionHistoryStatus.statusUpdate(revhistID);
   
}