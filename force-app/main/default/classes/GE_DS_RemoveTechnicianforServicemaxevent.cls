public class GE_DS_RemoveTechnicianforServicemaxevent
{ 
   public static Boolean isFirstTime = false;
   public void Eventtechnician(list<SVMXC__SVMX_Event__c> levents ){ 
  //List<SVMXC__SVMX_Event__c>lsevents=new List<SVMXC__SVMX_Event__c>();
   ID rectypeId=Schema.SObjectType.SVMXC__Service_Group_Members__c.getRecordTypeInfosByName().get('Digital Solutions Technician').getRecordTypeId(); 
   if(!GE_DS_RemoveTechnicianforServicemaxevent.isFirstTime){
   GE_DS_RemoveTechnicianforServicemaxevent.isFirstTime = True; 
   for(SVMXC__SVMX_Event__c SEvent:[select id,GE_DS_Approval_Status__c,SVMXC__Technician__c,SVMXC__Technician__r.RecordTypeId from SVMXC__SVMX_Event__c where id in:levents and SVMXC__Technician__r.RecordTypeId=:rectypeId and GE_DS_Approval_Status__c =:'Rejected']){
   SEvent.SVMXC__Technician__c=null;
   update SEvent;
       }
     }
   }
}