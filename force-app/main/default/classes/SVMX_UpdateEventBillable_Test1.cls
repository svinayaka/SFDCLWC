@isTest(SeeAllData=true)
private class SVMX_UpdateEventBillable_Test1{
   static testMethod void UpdateEventBillable(){
    List<SVMXC__SVMX_Event__c> woeventlist = new List<SVMXC__SVMX_Event__c>();
    //List<SVMXC__SVMX_Event__c> woevent = new List<SVMXC__SVMX_Event__c>();
    //woevent = [select Id, Name, GE_OG_DS_Assignment_Type__c, SVMXC__Technician__c, Is_Billable__c, SVMXC__StartDateTime__c, SVMXC__EndDateTime__c, SVMXC__WhatId__c from SVMXC__SVMX_Event__c where GE_OG_DS_Assignment_Type__c = 'Deployed' and SVMXC__WhatId__c IN:wolist and SVMXC__Technician__c IN:techid];
     
    //system.assertequals(1,woevent.size());
    SVMXC__Skill__c skill=new SVMXC__Skill__c();
    insert skill;
    SVMXC__Service_Order__c WO=new SVMXC__Service_Order__c();
    WO.SVMXC__Skill__c=skill.id;
    insert WO;
    SVMXC__Service_Group__c ser_team=new SVMXC__Service_Group__c();
    insert ser_team;
    SVMXC__Service_Group_Members__c tech=new SVMXC__Service_Group_Members__c();
    tech.SVMXC__Service_Group__c=ser_team.id;
    insert tech;
    
    SVMXC__SVMX_Event__c woevent=new SVMXC__SVMX_Event__c( );
    woevent.GE_OG_DS_Event_Status__c='Pending Approval';
    woevent.Is_Billable__c='YES';
    woevent.GE_OG_DS_Assignment_Type__c = 'Deployed';
    woevent.SVMXC__StartDateTime__c=Date.newInstance(2015, 1, 3);
    woevent.SVMXC__EndDateTime__c=Date.newInstance(2015, 1, 4);
    woevent.SVMXC__WhatId__c=WO.Id;
    woevent.SVMXC__Technician__c=tech.id;
    insert woevent;  
    System.debug('WOEVENT'+woevent);
    Id rtId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Usage/Consumption').getRecordTypeId();
    SVMXC__Service_Order_Line__c WODetails=new SVMXC__Service_Order_Line__c();
    WODetails.RecordTypeId=rtId;
    WODetails.SVMXC__Line_Type__c='Labor';
    WODetails.SVMXC__Group_Member__c=tech.id;
    WODetails.SVMXC__Service_Order__c=WO.Id;
    insert WODetails;
    
}
}