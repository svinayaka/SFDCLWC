trigger GE_OG_UpdatePrimaryAccountTrigger on Contract (after insert, after update) {

  FAAccountTriggerHandler handler = new FAAccountTriggerHandler();

  // Getting Master Frame Agreement record type ID
  Schema.DescribeSObjectResult des = Schema.SObjectType.Contract;
  Map<String,Schema.RecordTypeInfo> rtMapByName = des.getRecordTypeInfosByName();
  Schema.RecordTypeInfo rtByName =  rtMapByName.get('Master Frame Agreement');
  Id FARecId = rtByName.getRecordTypeId(); 
  System.debug('FARecId;'+FARecId );   
     
  if( Trigger.isInsert && Trigger.isAfter) {
        handler.OnAfterInsert(Trigger.new, new Set<Id>{FARecId});
  } else if( Trigger.isUpdate && Trigger.isAfter) { 
        handler.OnAfterUpdate(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap, new Set<Id>{FARecId});
  }

}