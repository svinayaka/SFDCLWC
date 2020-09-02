/*
Req: R-24661

Class Name              :        GE_HQ_WorkorderTechUnAssignment
Class called in         :        GE_OG_SVMX_Event_TriggerHandler
Purpose                 :        when the work order is un-assigned or deleted then an un-assigned mail will be triggered to respective techinician.
Test class              :        GE_OG_MCS_WorkorderTechUnAssignment_test
*/


public class GE_HQ_WorkorderTechUnAssignment{
    
    public static void getTechnicianEmail(List<SVMXC__SVMX_Event__c> eventList){
                    
        Set<Id> eventIds=new Set<Id>();
        Set<Id> techids = new Set<Id>();
        Set<Id> woIds = new Set<Id>();
        List<SVMXC__SVMX_Event__c> events=new List<SVMXC__SVMX_Event__c>();
        List<SMaxEventEmailBean> MyBeanList = new List<SMaxEventEmailBean>();
        List<SMaxEventEmailBean> MyBeanList1 = new List<SMaxEventEmailBean>();
        List<SMaxEventEmailBean> MyBeanListCal = new List<SMaxEventEmailBean>();
        Map<Id,SVMXC__Service_Group_Members__c> techMap = new Map<Id,SVMXC__Service_Group_Members__c>();
        Map<Id,SVMXC__Service_Order__c> woMap = new Map<Id,SVMXC__Service_Order__c>();
        for(SVMXC__SVMX_Event__c e:eventList){
            events.add(e);
            techids.add(e.SVMXC__Technician__c);
            woIds.add(e.SVMXC__Service_Order__c);            
        }
        if(!events.isempty()){        
            techMap =new Map<Id,SVMXC__Service_Group_Members__c>([Select Id,SVMXC__Email__c,SVMXC__Salesforce_User__r.Email from SVMXC__Service_Group_Members__c where Id in :techIds]);
            woMap=new Map<Id,SVMXC__Service_Order__c>([Select Id,RecordType.Name,SVMXC__Order_Type__c,SVMXC__Dispatch_Status__c from SVMXC__Service_Order__c where Id in :woIds]);
           
            for(SVMXC__SVMX_Event__c e :events){            
                if(e.SVMXC__Service_Order__c!= null && e.SVMXC__Technician__c!=null){                   
                    if(woMap.get(e.SVMXC__Service_Order__c).RecordType.Name== 'MCS'){ 
                        if(techMap.containskey(e.SVMXC__Technician__c) && techMap.get(e.SVMXC__Technician__c).SVMXC__Email__c!=null){
                             MyBeanList.add(new SMaxEventEmailBean(e,techMap.get(e.SVMXC__Technician__c).SVMXC__Email__c));                           
                        }
                    }else{
                            // added as part of requirement R-25704 woMap.get(e.SVMXC__Service_Order__c).SVMXC__Dispatch_Status__c!='Queued'
                       if((woMap.get(e.SVMXC__Service_Order__c).RecordType.Name=='GE OG DTS')&&(woMap.get(e.SVMXC__Service_Order__c).SVMXC__Dispatch_Status__c!='Queued')&&(woMap.get(e.SVMXC__Service_Order__c).SVMXC__Order_Type__c=='Field Service')){                           
                          if(techMap.containskey(e.SVMXC__Technician__c) && techMap.get(e.SVMXC__Technician__c).SVMXC__Email__c!=null){                                      
                              MyBeanListCal.add(new SMaxEventEmailBean(e,techMap.get(e.SVMXC__Technician__c).SVMXC__Email__c));                              
                            }
                    }
                    
                    }
                   System.debug('Work Order Status '+(woMap.get(e.SVMXC__Service_Order__c).SVMXC__Dispatch_Status__c));
                    // added as part of requirement R-31672 un-assigned mail will be triggered to respective techinician.
                    if((woMap.get(e.SVMXC__Service_Order__c).RecordType.Name== 'AL')&&(woMap.get(e.SVMXC__Service_Order__c).SVMXC__Dispatch_Status__c=='Assigned')){ 
                    System.debug('Work Order Status '+(woMap.get(e.SVMXC__Service_Order__c).SVMXC__Dispatch_Status__c));
                        if(techMap.containskey(e.SVMXC__Technician__c) && techMap.get(e.SVMXC__Technician__c).SVMXC__Salesforce_User__r.Email!=null){
                             MyBeanList1.add(new SMaxEventEmailBean(e,techMap.get(e.SVMXC__Technician__c).SVMXC__Salesforce_User__r.Email));                           
                        }
                    }
                        
                 }
              }  
             
         
         if(Label.MCS_UnassignmentTechEmail=='yes'){
                try{
                 if(MyBeanList.size()>0){
                  sendMCSUnassignedEmail(MyBeanList);
                  }
                  if(MyBeanListCal.size()>0){
                  sendCancellationEmail(MyBeanListCal); 
                  } 
                  if(MyBeanList1.size()>0){
                  sendALUnassignedEmail(MyBeanList1); 
                  } 
                }catch(Exception e){                    
                    System.debug('EMail sending  fail: '+e.getMessage());
                }             
            }
       }
    }
    public static void sendMCSUnassignedEmail(List<SMaxEventEmailBean> events){
        EmailTemplate emailTemp = [Select id from EmailTemplate where Name in ('GE_OG_MC_WorkOrderTechUnAssigned1') LIMIT 1];
        Id templateId = emailTemp.id;
        Id Userid = UserInfo.getUserId();
        
        for(SMaxEventEmailBean obj:events){
            System.debug('-------->'+obj);              
            System.debug('user id---------->'+Userid);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            if(obj.event.Id!=null) {
                mail.setTemplateId(templateId);
                mail.setTargetObjectId(Userid);
                mail.setWhatId(obj.event.id) ; 
                System.debug('event is is=============='+obj.event.id);
                mail.setUseSignature(false);
                mail.setSaveAsActivity(false);
                mail.setToAddresses(new String[] {obj.emailId});
            }
            System.debug('Before mail sending --------->');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
            System.debug('after mail sending --------->');
            }          
        }
        
         //////////Subra Added for Cancelation for "DTS Work Order Cancellation Template"
        public static void sendCancellationEmail(List<SMaxEventEmailBean> events){
        EmailTemplate emailTemp2 = [Select id from EmailTemplate where Name ='DTS Work Order Cancellation Template'  LIMIT 1];
        Id templateId2 = emailTemp2.id;
        Id Userid = UserInfo.getUserId();
        
        for(SMaxEventEmailBean obj:events){
            System.debug('Subra -------->'+obj);              
            System.debug('Subra user id---------->'+Userid);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            if(obj.event.Id!=null) {
                mail.setTreatTargetObjectAsRecipient(false);
                mail.setTemplateId(templateId2);
                mail.setTargetObjectId(Userid);
                mail.setWhatId(obj.event.id) ; 
                mail.setTreatTargetObjectAsRecipient(false);
                mail.setUseSignature(false);
                mail.setSaveAsActivity(false);
                mail.setToAddresses(new String[] {obj.emailId});
            }
            System.debug('Subra   Before mail sending --------->');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
            System.debug('Subra   after mail sending --------->');
            }
     } 
     // added as part of requirement R-31672 un-assigned mail will be triggered to respective techinician.
     
      public static void sendALUnassignedEmail(List<SMaxEventEmailBean> events){
        EmailTemplate emailTemp1 = [Select id from EmailTemplate where Name in ('GE AL WorkOrderTechnicianUnAssigned')  LIMIT 1];
        Id templateId1 = emailTemp1.id;
        Id Userid = UserInfo.getUserId();
        
        for(SMaxEventEmailBean obj:events){
            System.debug('AL -------->'+obj);              
            System.debug('AL user id---------->'+Userid);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            if(obj.event.Id!=null) {
                mail.setTreatTargetObjectAsRecipient(false);
                mail.setTemplateId(templateId1);
                mail.setTargetObjectId(Userid);
                mail.setWhatId(obj.event.id) ; 
                mail.setUseSignature(false);
                mail.setSaveAsActivity(false);
                mail.setToAddresses(new String[] {obj.emailId});
            }
            System.debug('AL   Before mail sending --------->');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
            System.debug('AL   after mail sending --------->');
            }
     } 
     
    public class SMaxEventEmailBean{
    public SVMXC__SVMX_Event__c event = new SVMXC__SVMX_Event__c();
    public String emailId;
    public SMaxEventEmailBean(SVMXC__SVMX_Event__c smEvent, String techEmail){
       event= smEvent;
       emailId=techEmail;
    }
 }
    
}