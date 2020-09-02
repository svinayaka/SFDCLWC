@isTest(seealldata=true)
public class GE_PC_EventHelper_Test{


static testMethod  void sendMailToTechnicians(){

    Test.StartTest();
    List<SVMXC__Service_Order__c> woList = new List<SVMXC__Service_Order__c>();
    SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();
    Id wortid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();
    woObj.RecordTypeId=wortid;
    woObj.SVMXC__Order_Status__c = 'Opened';
    woObj.GE_SM_HQ_Scheduled_Start_Date_Time__c = datetime.now();
    woObj.GE_SM_HQ_Scheduled_End_Date_Time__c = datetime.now();
    woList.add(woObj);
    List<Event> evtList = new List<Event>();
    List<Event> evtList2 = new List<Event>();
    insert woList;
    
    Event evt = new Event();
    evt.Subject ='Research';
    evt.DurationInMinutes=10;
    evt.ActivityDateTime=date.today();
    evt.whatId = woObj.id;
    evtList.add(evt);
    
    Event evt2 = new Event();
    evt2.Subject ='Research';
    evt2.DurationInMinutes=10;
    evt2.ActivityDateTime=date.today();
    evt2.whatId = woObj.id;
    insert evt2;
    evtList2.add(evt2);
    
    insert evtList;
    evt2.Subject='Test';
    update evt2;
    update evtList2;
    
    delete evtList2;
    
    undelete evtList2;
    
    

    Map<Id,Event> eventIdMap = new Map<Id,Event>();
    eventIdMap.put(woObj.id,evt);
    
    List<String> sendTo = new List<String>();
    GE_PC_EventHelper eventHelper = new GE_PC_EventHelper(); 
    GE_PC_EventTriggerHandler   eventHandler = new GE_PC_EventTriggerHandler();
    eventHandler.OnBeforeInsert(evtList);
    eventHandler.OnBeforeUpdate(evtList,evtList,eventIdMap);
    eventHandler.OnAfterUpdate(evtList,evtList,eventIdMap);
    eventHandler.OnBeforeDelete(evtList,eventIdMap);
    eventHandler.OnAfterDelete(evtList,eventIdMap);
    eventHandler.OnUndelete(evtList);
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setToAddresses(sendTo);
    mail.setSubject('You have been assigned to work order:'+ woObj.Name+' for '+woObj.SVMXC__Company__r.Name);
    String body = 'You have been assigned to ' +woObj.Name;
    mail.setHtmlBody(body);
    Test.StopTest();
    }
    
}