@isTest
Private class GE_DS_UpdateCasePriorityTest{

 static testmethod void updatecasepriority(){
 
   List<RecordType> Recname = [Select id, Name from Recordtype where Name=:'DS - CSR'];
 
     Case c = new Case();
     c.RecordTypeId = Recname[0].id;
     c.GE_ES_Sub_Type__c = 'RFQ processing';
  c.GE_ES_Customer_Request_Date__c = Date.Today().adddays(20);
     insert c;
     
     Task t = new Task();
     t.Subject = 'Call';
     t.Whatid = c.id;
     t.Status = 'In Progress';
     t.Priority = 'Normal';
     insert t;
        
 
 }


}