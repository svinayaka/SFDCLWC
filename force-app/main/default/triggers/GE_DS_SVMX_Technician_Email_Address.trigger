/*****************
Author: ForeFront/Ryan Cerankowski
GE OG D&S
Summary: This trigger is responsible for setting the current technician and previous technician fields on the Work Order
These fields are utilized in a Workflow rule/Email update to notify technicians when they have been unassigned from a Work Order
or if the Scheduled Dates change on a Work Order
Modified by: Jagan Mohan
Reason: Added few lines of code to populate Service Team Leader Email from Service Team to Work Order.

*****************/

trigger GE_DS_SVMX_Technician_Email_Address on SVMXC__Service_Order__c (before update) {
    Set<Id> techIds = new Set<Id>();
    Set<Id> sertIds=new Set<Id>();
    List<SVMXC__Service_Order__c> serviceOrders = new List<SVMXC__Service_Order__c>();
    List<SVMXC__Service_Order__c> sles = new List<SVMXC__Service_Order__c>();
         Schema.SObjectType s = SVMXC__Service_Order__c.sObjectType;
     Schema.DescribeSObjectResult resSchema = s.getDescribe() ;
     Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); //getting all Recordtype for the Sobject
     Id rtId = recordTypeInfo.get('D&S').getRecordTypeId();//particular RecordId by  Name
     Id pcId = recordTypeInfo.get('PC').getRecordTypeId();//particular RecordId by  Name
    
    
    for(SVMXC__Service_Order__c trig : trigger.new){
        if(trig.SVMXC__Group_Member__c != trigger.oldMap.get(trig.Id).SVMXC__Group_Member__c){
            trig.GE_DS_Previous_Technician_Email__c = trigger.oldMap.get(trig.Id).Technician_Email__c;
            techIds.add(trig.SVMXC__Group_Member__c);
            serviceOrders.add(trig);
        }
        if(trig.SVMXC__Group_Member__c == null){
            trig.Technician_Email__c = null;
        }
        if((trig.RecordTypeID==rtId||trig.RecordTypeID==pcId) && trig.SVMXC__Group_Member__c != null && trig.GE_SM_HQ_Dispatched_Outside_Territory__c == true){
        system.debug('***Entered loop');
        
            sertIds.add(trig.SVMXC__Service_Group__c);
            sles.add(trig);
        }
    }
    
    if(techIds.size() > 0){
        Map<Id,SVMXC__Service_Group_Members__c> technicians =
            new Map<Id,SVMXC__Service_Group_Members__c>([SELECT Id, Name, SVMXC__Email__c FROM SVMXC__Service_Group_Members__c WHERE Id in :techIds]);
        
        for(SVMXC__Service_Order__c svcOrder : serviceOrders){
            if(technicians.get(svcOrder.SVMXC__Group_Member__c) != null){
                svcOrder.Technician_Email__c = technicians.get(svcOrder.SVMXC__Group_Member__c).SVMXC__Email__c;   
            }
        }
    }
    
    if(sles.size()>0){
        Map<Id,SVMXC__Service_Group__c> serteams =new Map<Id,SVMXC__Service_Group__c>([SELECT Id, Name, GE_HQ_Resource_Director__r.Email FROM SVMXC__Service_Group__c WHERE Id in :sertIds]);
            
            for(SVMXC__Service_Order__c wo : sles){
            system.debug('***ST Email');

            wo.GE_DS_Service_Team_Leader_Email__c=serteams.get(wo.SVMXC__Service_Group__c).GE_HQ_Resource_Director__r.Email;

            }

    
    }
        
}