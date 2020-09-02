@isTest(SeeAllData=true)
private class GE_SS_CallParentUpdate_Test {

    public testmethod static void testWorkDetailLine()
    {
        Id csrtid = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-SS').getRecordTypeId();
        id cslrtid = Schema.SObjectType.SVMXC__Case_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id wdlrtid = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        Id wortid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Trip').getRecordTypeId();
        
        Id UserId = UserInfo.getUserId();
        //String useremail = UserInfo.getUserEmail();
        User u = [SELECT UserName,Email FROM User where Id =: UserId]; 
            
        Account acc = new Account(Name = 'SVMX Test Account');
        insert acc;
        System.assertEquals(acc.Name,'SVMX Test Account');
        
        Product2 prod = new Product2(Name='Test Prod',
                                    ProductCode = '1234');
        insert prod;
        System.assertEquals(prod.Name,'Test Prod');

        
        SVMXC__Installed_Product__c ib = new SVMXC__Installed_Product__c(
                                    Name = 'TestIB',
                                    SVMXC__Product__c = prod.id,
                                    GE_AL_Installed_Product_Type__c  = 'Tools');
        insert ib;
        System.assertEquals(ib.Name,'TestIB');
        
        SVMXC__Site__c loc1 = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                GE_SS_Project_Region__c = 'LAM',
                                Name = 'Test Field Loc',
                                SVMXC__Latitude__c = 37.662533,
                                SVMXC__Longitude__c = 121.874730,
                                Management_Country__c = 'Aruba');
                        insert loc1;
        
        Case cs = new Case(RecordTypeId = csrtid,
                            Status = 'New',
                            SVMXC__Component__c = ib.id,        //lookup to IB 
                            SVMXC__Product__c = prod.id,
                            GE_SS_Field__c = loc1.id);       //lookup to Product
        insert cs;
        System.assertEquals(cs.Status,'New');

        SVMXC__Case_Line__c csl = new SVMXC__Case_Line__c(
                            RecordTypeId = cslrtid,
                            SVMXC__Case__c = cs.id,                          
                            SVMXC__Quantity__c = 2);
        insert csl;
        System.assertEquals(csl.SVMXC__Quantity__c,2);
        
        SVMXC__Service_Order__c svo = new SVMXC__Service_Order__c(
                            RecordTypeId = wortid,
                            SVMXC__Company__c = acc.id,
                            SVMXC__Case__c = cs.id,
                            SVMXC__Order_Status__c = 'Opened',
                            SVMXC__Country__c  = 'United States',
                            GE_SS_No_of_Drilling_Personnel__c = 3);
        insert svo;
        System.assertEquals(svo.SVMXC__Order_Status__c,'Opened');
    
        Test.startTest();
   
        SVMXC__Service_Order_Line__c wdl = new SVMXC__Service_Order_Line__c(
                            RecordTypeId = wdlrtid,
                            GE_SS_Delivered__c='Yes',
                            GE_SS_Any_issue_during_performance__c ='Yes',
                            GE_SS_Has_Load_exceeded_rated_capacity__c ='Yes',
                            GE_Service_Performed_Critical_Spare_Part__c ='test',                            
                            GE_SS_How_was_tool_stored__c ='Basket',
                            GE_SS_Max_Tensile_Load_Applied__c =10,
                            GE_SS_Max_connection_make_up_Torque__c ='test',
                            GE_SS_Did_tool_see_any_pressure_Specify__c ='test',
                            SVMXC__Service_Order__c = svo.id,
                            Case_Line__c = csl.Id,
                            SVMXC__Serial_Number__c = ib.id,
                            SVMXC__Line_Status__c = 'Submitted',
                            GE_SS_Hours_Used__c = 2,
                            GE_SS_Used__c = 'Yes');
        insert wdl;

        
        Test.stopTest();
    }
    
    public testmethod static void testTechAssignment()
    {
        Id csrtid = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-SS').getRecordTypeId();
       Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        Id wortid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
       
        Id UserId = UserInfo.getUserId();
        // String useremail = UserInfo.getUserEmail();
        User u = [SELECT UserName,Email FROM User where Id =: UserId Limit 1]; 
            
        Account acc = new Account(Name = 'SVMX Test Account');
        insert acc;
        System.assertEquals(acc.Name,'SVMX Test Account');
        
        Product2 prod = new Product2(Name='Test Prod',
                                    ProductCode = '1234');
        insert prod;
        System.assertEquals(prod.Name,'Test Prod');
        
        SVMXC__Site__c loc = new SVMXC__Site__c(Name = 'testloc');
        insert loc;
        System.assertEquals(loc.Name,'testloc');
        
        SVMXC__Service_Group__c sg = new SVMXC__Service_Group__c( 
                                        Name = 'TestST',
                                        SVMXC__Country__c = 'United States',
                                        SVMXC__Active__c = true);
        insert sg;
        System.assertEquals(sg.Name,'TestST');      
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
                                        Name = 'Test Tech',
                                        SVMXC__Service_Group__c = sg.id,                                      
                                        SVMXC__Enable_Scheduling__c = true,
                                        SVMXC__Active__c = true,
                                        SVMXC__Email__c = 'abc@xzy.com',
                                        SVMXC__Salesforce_User__c = UserInfo.getUserId());
        insert tech;
        System.assertEquals(tech.SVMXC__Enable_Scheduling__c,true);
        
        SVMXC__Product_Stock__c pstk = new SVMXC__Product_Stock__c(
                                        SVMXC__Location__c = loc.id,
                                        SVMXC__Product__c = prod.id,
                                        SVMXC__Status__c = 'Available');
        
        insert pstk;
        System.assertEquals(pstk.SVMXC__Status__c,'Available');
        
        SVMXC__Installed_Product__c ib = new SVMXC__Installed_Product__c(
                                    Name = 'TestIB',
                                    SVMXC__Product__c = prod.id);
        insert ib;
        System.assertEquals(ib.Name,'TestIB');
        
        
        SVMXC__Site__c loc1 = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                GE_SS_Project_Region__c = 'LAM',
                                Name = 'Test Field Loc',
                                SVMXC__Latitude__c = 37.662533,
                                SVMXC__Longitude__c = 121.874730,
                                Management_Country__c = 'Aruba');
                        insert loc1;
        
        Case cs = new Case(RecordTypeId = csrtid,
                            Status = 'New',
                            SVMXC__Component__c = ib.id,        //lookup to IB 
                            SVMXC__Product__c = prod.id,
                            GE_SS_Field__c = loc1.id);       //lookup to Product
        insert cs;
        
        System.assertEquals(cs.Status,'New');
       
        

        
       SVMXC__Service_Order__c svo = new SVMXC__Service_Order__c(
                            RecordTypeId = wortid ,
                            SVMXC__Company__c = acc.id,
                            SVMXC__Case__c = cs.id,
                            SVMXC__Order_Status__c = 'Open',
                            GE_SS_No_of_Drilling_Personnel__c = 3); 
        insert svo;
        
        Event ev = new Event(OwnerId = Userinfo.getUserId(),
                            Subject = 'TestEvent',
                            StartDateTime = System.now(),
                            EndDateTime = System.now(),
                            WhatId = svo.id);
        insert ev;  
        
        
    }
    
    public testmethod static void testServiceTicketUpdate()
    {
        
       

        Id csrtid = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-SS').getRecordTypeId();
       Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
       Id Techrecid = Schema.SObjectType.SVMXC__Service_Group_Members__c.getRecordTypeInfosByName().get('SubSea').getRecordTypeId();
        
        Id wortid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
       
        Id UserId = UserInfo.getUserId();
        // String useremail = UserInfo.getUserEmail();
        User u = [SELECT UserName,Email FROM User where Id =: UserId Limit 1]; 
         
            
        Account acc = new Account(Name = 'SVMX Test Account');
        insert acc;
        System.assertEquals(acc.Name,'SVMX Test Account');
        
        Product2 prod = new Product2(Name='Test Prod',
                                    ProductCode = '1234');
        insert prod;
        System.assertEquals(prod.Name,'Test Prod');
        
        SVMXC__Site__c loc = new SVMXC__Site__c(Name = 'testloc');
        insert loc;
        System.assertEquals(loc.Name,'testloc');
        
         
        
        SVMXC__Service_Group__c sg = new SVMXC__Service_Group__c( 
                                        Name = 'TestST',
                                        SVMXC__Country__c = 'United States',
                                   SVMXC__Active__c = true);
        
        insert sg;
        
        System.assertEquals(sg.Name,'TestST');      
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
                                        Name = 'Test Tech',
                                        SVMXC__Service_Group__c = sg.id,                                      
                                        SVMXC__Enable_Scheduling__c = true,
                                        RecordTypeId = Techrecid, 
                                        SVMXC__Active__c = true,
                                        SVMXC__Email__c = 'abc@xzy.com',
                                        SVMXC__Salesforce_User__c = UserInfo.getUserId());
        insert tech;
        
        System.assertEquals(tech.SVMXC__Enable_Scheduling__c,true);
        
        SVMXC__Product_Stock__c pstk = new SVMXC__Product_Stock__c(
                                        SVMXC__Location__c = loc.id,
                                        SVMXC__Product__c = prod.id,
                                        SVMXC__Status__c = 'Available');
        
        insert pstk;
        System.assertEquals(pstk.SVMXC__Status__c,'Available');
        
        SVMXC__Installed_Product__c ib = new SVMXC__Installed_Product__c(
                                    Name = 'TestIB',
                                    SVMXC__Product__c = prod.id);
        insert ib;
        
        System.assertEquals(ib.Name,'TestIB');
        
        SVMXC__Site__c loc1 = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                GE_SS_Project_Region__c = 'LAM',
                                Name = 'Test Field Loc',
                                SVMXC__Latitude__c = 37.662533,
                                SVMXC__Longitude__c = 121.874730,
                                Management_Country__c = 'Aruba');
                        insert loc1;
        
        Case cs = new Case(RecordTypeId = csrtid,
                            Status = 'New',
                            SVMXC__Component__c = ib.id,        //lookup to IB 
                            SVMXC__Product__c = prod.id,
                            GE_SS_Field__c = loc1.id);       //lookup to Product
        insert cs;
        
        System.assertEquals(cs.Status,'New');
       
        
Test.startTest();
        
       SVMXC__Service_Order__c svo = new SVMXC__Service_Order__c(
                            RecordTypeId = wortid ,
                            SVMXC__Company__c = acc.id,
                            SVMXC__Case__c = cs.id,
                            SVMXC__Group_Member__c = tech.id, 
                            SVMXC__Order_Status__c = 'Open',
                            GE_SS_No_of_Drilling_Personnel__c = 3); 
        insert svo;
        
        
          GE_SS_Service_Ticket__c st1 = new GE_SS_Service_Ticket__c();
            st1.GE_SS_Service_Representative__c = tech.id;
            st1.GE_SS_Service_Start_Date__c = Date.newInstance(2015, 12, 31);
            st1.GE_SS_Service_Finish_Date__c = Date.newInstance(2016, 01, 28);
            st1.GE_SS_Status__c = 'Complete';
            st1.GE_SS_Work_Order__c = svo.id;
            insert st1;
        
        GE_SS_Service_Ticket__c st2 = new GE_SS_Service_Ticket__c();
            st2.GE_SS_Service_Representative__c = tech.id;
            st2.GE_SS_Service_Start_Date__c = Date.newInstance(2016, 11, 30);
            st2.GE_SS_Service_Finish_Date__c = Date.newInstance(2016, 11, 30);
            st2.GE_SS_Work_Order__c = svo.id;
            st2.GE_SS_Status__c = 'Complete';
            insert st2;
            
        GE_SS_Service_Ticket__c st3 = new GE_SS_Service_Ticket__c();
            st3.GE_SS_Service_Representative__c = tech.id;
            st3.GE_SS_Service_Start_Date__c = Date.newInstance(2016, 12, 31);
            st3.GE_SS_Service_Finish_Date__c = Date.newInstance(2017, 11, 30);
            st3.GE_SS_Work_Order__c = svo.id;
            st3.GE_SS_Status__c = 'Complete';
            insert st3;
            
        GE_SS_Service_Ticket__c st4 = new GE_SS_Service_Ticket__c();
            st4.GE_SS_Service_Representative__c = tech.id;
            st4.GE_SS_Service_Start_Date__c = Date.newInstance(2015, 12, 31);
            st4.GE_SS_Service_Finish_Date__c = Date.newInstance(2017, 11, 30);
            st4.GE_SS_Work_Order__c = svo.id;
            st4.GE_SS_Status__c = 'Complete';
            insert st4;
            Test.stopTest();
            
        delete st4;
            
        Work_Activity__c objTA = new Work_Activity__c();
        objTA.Work_Order__c = svo.Id;
        objTA.Technician_Equipment__c = tech.id;
        objTA.StartTime__c = DateTime.newInstance(2015, 12, 31, 00, 00, 00);
        objTA.EndTime__c = DateTime.newInstance(2016, 11, 30, 00, 00, 00);
        insert objTA;
        
        Work_Activity__c objTA1 = new Work_Activity__c();
        objTA1.Work_Order__c = svo.Id;
        objTA1.Technician_Equipment__c = tech.id;
        objTA1.StartTime__c = DateTime.newInstance(2016, 01, 01, 00, 00, 00);
        objTA1.EndTime__c = DateTime.newInstance(2016, 12, 31, 00, 00, 00);
        insert objTA1;
        
        Work_Activity__c objTA2 = new Work_Activity__c();
        objTA2.Work_Order__c = svo.Id;
        objTA2.Technician_Equipment__c = tech.id;
        objTA2.StartTime__c = DateTime.newInstance(2016, 12, 31, 00, 00, 00);
        objTA2.EndTime__c = DateTime.newInstance(2017, 11, 30, 00, 00, 00);
        insert objTA2;
        
        Work_Activity__c objTA3 = new Work_Activity__c();
        objTA3.Work_Order__c = svo.Id;
        objTA3.Technician_Equipment__c = tech.id;
        objTA3.StartTime__c = DateTime.newInstance(2015, 12, 31, 00, 00, 00);
        objTA3.EndTime__c = DateTime.newInstance(2017, 11, 30, 00, 00, 00);
        insert objTA3;
        
        delete objTA;
        
        

    }
    
    
}