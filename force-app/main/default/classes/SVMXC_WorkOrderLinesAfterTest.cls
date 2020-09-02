@isTest
Public class SVMXC_WorkOrderLinesAfterTest {    
    static testMethod void testWorkOrderLinesAfterInsert() {
        Set<Id> wdRTSet = new Set<Id>() ; 
        List<SVMXC__Service_Order_Line__c> wdList = new List<SVMXC__Service_Order_Line__c>();  
        List<SVMXC__Service_Order_Line__c> tripWdInsertList = new List<SVMXC__Service_Order_Line__c>();  
        List<SVMXC__Service_Order_Line__c> tripWdUpdateList = new List<SVMXC__Service_Order_Line__c>();                   
        Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId() ;
        Id SSMobilize =  Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId() ;
        Id SSTrip =  Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Trip').getRecordTypeId();
        Id SSIP =  Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('Subsea Equipment').getRecordTypeId();        
        Id sparesRtId = Schema.SObjectType.SVMXC__Service_Order_line__c.getRecordTypeInfosByName().get('Spares').getRecordTypeId();
        Id EquipmentRtId = Schema.SObjectType.SVMXC__Service_Order_line__c.getRecordTypeInfosByName().get('Equipment').getRecordTypeId();
        Id ToolsRtId = Schema.SObjectType.SVMXC__Service_Order_line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        wdRTSet.add(sparesRtId) ;
        wdRTSet.add(EquipmentRtId) ;
        wdRTSet.add(ToolsRtId) ;
        Test.startTest(); 
        // insert Site         
        SVMXC__Site__c loc = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                                                                    GE_SS_Project_Region__c = 'LAM',
                                                                                    Name = 'Test Field Loc',
                                                                                    SVMXC__Latitude__c = 37.662533,
                                                                                    SVMXC__Longitude__c = 121.874730,
                                                                                    Management_Country__c = 'Aruba');
        insert loc;   
        
        // Insert Work order
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c(
                                                                                                                  RecordTypeId = SSMobilize,
                                                                                                                  //SVMXC__Company__c = acc.id,
                                                                                                                 //SVMXC__Case__c = cs.id,
                                                                                                                  SVMXC__Order_Status__c = 'Opened',
                                                                                                                  GE_SS_Field__c = loc.id,
                                                                                                                  SVMXC__Country__c  = 'United States',
                                                                                                                  GE_SS_No_of_Drilling_Personnel__c = 3);
        insert wo ;   
        
        //Insert Trip WO
        SVMXC__Service_Order__c tripWO = new SVMXC__Service_Order__c(
                                                                                                                            RecordTypeId = SSTrip,
                                                                                                                            //SVMXC__Company__c = acc.id,
                                                                                                                            //SVMXC__Case__c = cs.id,
                                                                                                                            SVMXC__Order_Status__c = 'Open',
                                                                                                                            GE_SS_Field__c = loc.id,
                                                                                                                            SVMXC__Country__c  = 'United States',
                                                                                                                            GE_SS_Parent_Work_Order__c = wo.id,
                                                                                                                            GE_SS_No_of_Drilling_Personnel__c = 3,
                                                                                                                            GE_SS_Downtime_NPT_Hours__c = 0,
                                                                                                                            GE_SS_Uptime_Hours__c = 0);              
        insert tripWO ;    
        
        // insert IP
        SVMXC__Installed_Product__c IP = new SVMXC__Installed_Product__c(Name='TestIP',
                                                                                                                              SVMXC__Status__c = 'Installed',
                                                                                                                              GE_AL_Installed_Product_Type__c='Spares',
                                                                                                                              SVMXC__City__c = 'Test', 
                                                                                                                              SVMXC__Country__c = 'USA',
                                                                                                                              SVMXC__Installation_Notes__c = 'Test Notes', 
                                                                                                                              SVMXC__Company__c='0011200001GKLin',
                                                                                                                              GE_SS_Quantity__c = 1, 
                                                                                                                              RecordTypeId = SSIP );
        insert IP ;
        for(Id wdRt : wdRTSet){
              SVMXC__Service_Order_line__c MobWOline = new SVMXC__Service_Order_line__c() ;
              MobWOline.RecordTypeId = wdRT ;
              MobWOline.SVMXC__Actual_Quantity2__c = 2 ;
              MobWOline.SVMXC__Serial_Number__c = IP.Id ;
              MobWOline.SVMXC__Service_Order__c = wo.Id ;
              wdList.add(MobWOline) ;
        }
                                                                                                                                                                                                                                                                                                                      
         insert wdList;   
         
         for(SVMXC__Service_Order_line__c  mobWL : wdList){
                 SVMXC__Service_Order_line__c TripWOline = new SVMXC__Service_Order_line__c();
                 TripWOline.RecordTypeId = sparesRtId ;
                 TripWOline.SVMXC__Serial_Number__c = IP.Id;
                 TripWOline.SVMXC__Service_Order__c = tripWO.Id;
                 TripWOline.SVMXC__Work_Detail__c = mobWL.Id;
                  tripWdInsertList.add(TripWOline);
         }
         
         insert tripWdInsertList; 
         
         for(SVMXC__Service_Order_line__c  mobWL : wdList){
                 SVMXC__Service_Order_line__c TripWOline = new SVMXC__Service_Order_line__c();
                 TripWOline.RecordTypeId = EquipmentRtId ;
                 TripWOline.Id = mobWL.Id ;
                 tripWdUpdateList.add(TripWOline) ;
         }
          
         update tripWdUpdateList ;
         
        Test.stopTest();
    }
}