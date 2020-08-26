/*
Test Class : Test_GE_ES_CaseTrashBin_ctrl_delete

*/

trigger CheckChatterPostsOnCase  on FeedItem (After Insert) {

   // Get the key prefix for the Case object
   // using a describe call.
   String caseKeyPrefix = Case.sObjectType.getDescribe().getKeyPrefix();
   Set<Id> caseIds = new Set<Id>();
 //  ID caseMCSCSRecordType = [SELECT Id FROM RecordType WHERE Name = 'MCS - CS'].Id;
  // ID caseMCSTSRecordType = [SELECT Id FROM RecordType WHERE Name = 'MC-TS'].Id;
   
    Id caseMCSCSRecordType = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();
   ID caseMCSTSRecordType = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MC-TS').getRecordTypeId();
   Datetime CreatedDateDt = null;
      
   System.debug('caseKeyPrefix ::'+caseKeyPrefix);
   
   for (FeedItem f: trigger.new){
      
         String parentId = f.parentId;
         if (parentId.startsWith(caseKeyPrefix))
         {
               // Add your business logic here
               caseIds.add(parentId);                   
         }
   }
   
   List<Case> listCases = [Select Id, Status From Case Where Id = :caseIds and (RecordTypeId = :caseMCSCSRecordType or RecordTypeId = :caseMCSTSRecordType) ];
   System.debug('Size::'+listCases.size());   
   if(listCases != null && listCases.size() > 0 ){
       for(Case c : listCases)
       {
           c.Status= c.Status; 
       } 
       try
       {
       update listCases; 
       }catch(DMLException e)
       {
       trigger.new[0].addError('There has been an error. Please check Subtype is filled for MCS-CS or Read the below error for more information about the error: '+'\n\n'+e);
       //System.debug('Dml'+E);
       }
   }
   

}