/*
Author : Raju Manche
Requirement : R-31298
Class Name : SVMXC_WorkOrderLinesAfterTest_IPConfig 
Purpose : Code coverage for the SVMXC_WorkOrderLinesAfter class
*/
@isTest
Public class SVMXC_WorkOrderLinesAfterTest_IPConfig {
    static testMethod void testWorkOrderLinesAfter_sampleTrip() {
        List<SVMXC__Service_Order_Line__c> clList = new List<SVMXC__Service_Order_Line__c>();
        Map<Id, SVMXC__Service_Order_Line__c> triggerOld =  new Map<Id, SVMXC__Service_Order_Line__c> (); 
        Set<Id> IPSet =  new Set<Id> ();
        Map<Id, String> subSeaRTLookupMap = new Map<Id, String> ();
        
        Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        Test.startTest(); 
        // insert Site
        
        SVMXC__Site__c loc = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                                GE_SS_Project_Region__c = 'LAM',
                                                Name = 'Test Field Loc',
                                                SVMXC__Latitude__c = 37.662533,
                                                SVMXC__Longitude__c = 121.874730,
                                                Management_Country__c = 'Aruba');
        insert loc;
        
        //Case with Location
        Id SSMobilize =  Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        
        //  SVMXC__Service_Order__c c = new SVMXC__Service_Order__c(RecordTypeId=SSMobilize);
        List<SVMXC__Service_Order__c> orList  = new List<SVMXC__Service_Order__c>();
        
        SVMXC__Service_Order__c c = new SVMXC__Service_Order__c(
            RecordTypeId = SSMobilize,
            //SVMXC__Company__c = acc.id,
            //SVMXC__Case__c = cs.id,
            SVMXC__Order_Status__c = 'Opened',
            GE_SS_Field__c = loc.id,
            SVMXC__Country__c  = 'United States',
            
            GE_SS_No_of_Drilling_Personnel__c = 3);
        
        insert c;   
        //test.startTest();
        SVMXC__Service_Order__c c2 = new SVMXC__Service_Order__c(
            RecordTypeId = SSMobilize,
            //SVMXC__Company__c = acc.id,
            //SVMXC__Case__c = cs.id,
            SVMXC__Order_Status__c = 'Opened',
            GE_SS_Field__c = loc.id,
            SVMXC__Country__c  = 'United States',
            GE_SS_Parent_Work_Order__c =c.id,
            GE_SS_No_of_Drilling_Personnel__c = 3);
        insert c2;                                                                            
        
        Schema.SObjectType s = SVMXC__Service_Order_line__c.sObjectType;
        Schema.DescribeSObjectResult resSchema = s.getDescribe() ;
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        Id rtIdequip = recordTypeInfo.get('Equipment').getRecordTypeId();
        Id rtId = recordTypeInfo.get('Spares').getRecordTypeId();
        
        Id SSIP =  Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('Subsea Equipment').getRecordTypeId();
        // insert IP
        SVMXC__Installed_Product__c IP = new SVMXC__Installed_Product__c(Name='TsetIP',
                                                                         SVMXC__Status__c = 'Installed',
                                                                         GE_AL_Installed_Product_Type__c='Spares',
                                                                         SVMXC__City__c = 'Test', 
                                                                         SVMXC__Country__c = 'USA',
                                                                         SVMXC__Installation_Notes__c = 'Test Notes', 
                                                                         SVMXC__Company__c='0011200001GKLin',
                                                                         GE_SS_Quantity__c = 1, 
                                                                         RecordTypeId = SSIP );
        insert IP;
        IPSet.add(IP.ID);
        
        SVMXC__Service_Order_line__c MobWOline2 = new SVMXC__Service_Order_line__c();
        MobWOline2.RecordTypeId = rtIdequip;
        MobWOline2.SVMXC__Actual_Quantity2__c = 2;
        MobWOline2.SVMXC__Serial_Number__c = IP.Id;
        MobWOline2.SVMXC__Service_Order__c = c.Id;
        MobWOline2.SVMXC__Line_Status__c='Open';
        MobWOline2.GE_OG_SS_Product_Name__c='Test';
        MobWOline2.GE_OG_SS_Product_Description__c='Test';
        MobWOline2.SVMXC__Product__c='01t1H000005m4Hs';            
        MobWOline2.GE_SS_Pre_installed__c='Yes';
        MobWOline2.GE_SS_Usage_Type__c='Primary';
        insert MobWOline2;
        Test.stopTest();
        SVMXC__Service_Order_line__c MobWOline = new SVMXC__Service_Order_line__c();
        MobWOline.RecordTypeId = rtId;
        MobWOline.SVMXC__Actual_Quantity2__c = 2;
        MobWOline.SVMXC__Serial_Number__c = IP.Id;
        MobWOline.SVMXC__Service_Order__c = c.Id;
        MobWOline.SVMXC__Line_Status__c='Open';
        MobWOline.GE_OG_SS_Product_Name__c='Test';
        MobWOline.GE_OG_SS_Product_Description__c='Test';
        MobWOline.SVMXC__Product__c='01t1H000005m4Hs';            
        MobWOline.GE_SS_Pre_installed__c='Yes';
        MobWOline.GE_SS_Usage_Type__c='Primary';
        MobWOline.SVMXC__Work_Detail__c=MobWOline2.id;                       
        insert MobWOline;
        clList.add(MobWOline);                                
        //Test.stopTest();
    }    
}