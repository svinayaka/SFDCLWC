@isTest(SeeAllData=true)
private class GE_SS_Work_Detail_Line_on_IP_Test {

    public testmethod static void testWorkDetailLine()
    {
        Id csrtid = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-SS').getRecordTypeId();
        id cslrtid = Schema.SObjectType.SVMXC__Case_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        Id wdlrtid = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
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
        
        SVMXC__Site__c loc = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                GE_SS_Project_Region__c = 'LAM',
                                Name = 'Test Field Loc',
                                SVMXC__Latitude__c = 37.662533,
                                SVMXC__Longitude__c = 121.874730,
                                Management_Country__c = 'Aruba');
                        insert loc;
        
        Case cs = new Case(RecordTypeId = csrtid,
                            Status = 'New',
                            SVMXC__Component__c = ib.id,        //lookup to IB 
                            SVMXC__Product__c = prod.id,
                            GE_SS_Field__c = loc.id);       //lookup to Product
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
                            SVMXC__Country__c  = 'United States');
        insert svo;
        System.assertEquals(svo.SVMXC__Order_Status__c,'Opened');
    
        Test.startTest();
   
        SVMXC__Service_Order_Line__c wdl = new SVMXC__Service_Order_Line__c(
                            RecordTypeId = wdlrtid,
                            SVMXC__Service_Order__c = svo.id,
                            //Case_Line__c = csl.Id,
                             GE_SS_Delivered__c = 'Yes',
                            GE_SS_Any_issue_during_performance__c = 'Yes',
                            GE_SS_Has_Load_exceeded_rated_capacity__c = 'Yes',
                            GE_Service_Performed_Critical_Spare_Part__c = 'Test',
                            GE_SS_Used__c = 'Yes',
                            GE_SS_How_was_tool_stored__c = 'Basket',
                            GE_SS_Max_Tensile_Load_Applied__c = 1,
                            GE_SS_Max_connection_make_up_Torque__c = 'test',
                            GE_SS_Did_tool_see_any_pressure_Specify__c = 'test',
                            SVMXC__Serial_Number__c = ib.id,
                            SVMXC__Line_Status__c = 'Submitted');
        insert wdl;
        
        Test.setCurrentPageReference(new PageReference('Page.GE_SS_Work_Detail_Line_on_IP'));
        System.currentPageReference().getParameters().put('IP_Id', ib.id);
        GE_SS_Work_Detail_Line_on_IP objCls = new GE_SS_Work_Detail_Line_on_IP();
        
        Test.stopTest();
    }
    
    public testmethod static void testWorkDetailLine2()
    {
        Id csrtid = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-SS').getRecordTypeId();
        id cslrtid = Schema.SObjectType.SVMXC__Case_Line__c.getRecordTypeInfosByName().get('Equipment').getRecordTypeId();
        Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        Id wdlrtid = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Equipment').getRecordTypeId();
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
                                    GE_AL_Installed_Product_Type__c  = 'Equipment');
        insert ib;
        System.assertEquals(ib.Name,'TestIB');
        
        SVMXC__Site__c loc = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                GE_SS_Project_Region__c = 'LAM',
                                Name = 'Test Field Loc',
                                SVMXC__Latitude__c = 37.662533,
                                SVMXC__Longitude__c = 121.874730,
                                Management_Country__c = 'Aruba');
                        insert loc;
        
        Case cs = new Case(RecordTypeId = csrtid,
                            Status = 'New',
                            SVMXC__Component__c = ib.id,        //lookup to IB 
                            SVMXC__Product__c = prod.id,
                            GE_SS_Field__c = loc.id);       //lookup to Product
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
                            SVMXC__Country__c  = 'United States');
        insert svo;
        System.assertEquals(svo.SVMXC__Order_Status__c,'Opened');
    
        Test.startTest();
   
        SVMXC__Service_Order_Line__c wdl = new SVMXC__Service_Order_Line__c(
                            RecordTypeId = wdlrtid,
                            SVMXC__Service_Order__c = svo.id,
                            //Case_Line__c = csl.Id,
                             GE_SS_Delivered__c = 'Yes',
                            GE_SS_Any_issue_during_performance__c = 'Yes',
                            GE_SS_Has_Load_exceeded_rated_capacity__c = 'Yes',
                            GE_Service_Performed_Critical_Spare_Part__c = 'Test',
                            GE_SS_Used__c = 'Yes',
                            GE_SS_How_was_tool_stored__c = 'Basket',
                            GE_SS_Max_Tensile_Load_Applied__c = 1,
                            GE_SS_Max_connection_make_up_Torque__c = 'test',
                            GE_SS_Did_tool_see_any_pressure_Specify__c = 'test',
                            SVMXC__Serial_Number__c = ib.id,
                            SVMXC__Line_Status__c = 'Submitted');
        insert wdl;
        
        Test.setCurrentPageReference(new PageReference('Page.GE_SS_Work_Detail_Line_on_IP'));
        System.currentPageReference().getParameters().put('IP_Id', ib.id);
        GE_SS_Work_Detail_Line_on_IP objCls = new GE_SS_Work_Detail_Line_on_IP();
        
        Test.stopTest();
    }
    
    public testmethod static void testWorkDetailLine3()
    {
        Id csrtid = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-SS').getRecordTypeId();
        id cslrtid = Schema.SObjectType.SVMXC__Case_Line__c.getRecordTypeInfosByName().get('Spares').getRecordTypeId();
        Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        Id wdlrtid = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Spares').getRecordTypeId();
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
                                    GE_AL_Installed_Product_Type__c  = 'Spares');
        insert ib;
        System.assertEquals(ib.Name,'TestIB');
        
        SVMXC__Site__c loc = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                GE_SS_Project_Region__c = 'LAM',
                                Name = 'Test Field Loc',
                                SVMXC__Latitude__c = 37.662533,
                                SVMXC__Longitude__c = 121.874730,
                                Management_Country__c = 'Aruba');
                        insert loc;
        
        Case cs = new Case(RecordTypeId = csrtid,
                            Status = 'New',
                            SVMXC__Component__c = ib.id,        //lookup to IB 
                            SVMXC__Product__c = prod.id,
                            GE_SS_Field__c = loc.id);       //lookup to Product
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
                            SVMXC__Country__c  = 'United States');
        insert svo;
        System.assertEquals(svo.SVMXC__Order_Status__c,'Opened');
    
        Test.startTest();
   
        SVMXC__Service_Order_Line__c wdl = new SVMXC__Service_Order_Line__c(
                            RecordTypeId = wdlrtid,
                            SVMXC__Service_Order__c = svo.id,
                            //Case_Line__c = csl.Id,
                            GE_SS_Delivered__c = 'Yes',
                            GE_SS_Any_issue_during_performance__c = 'Yes',
                            GE_SS_Has_Load_exceeded_rated_capacity__c = 'Yes',
                            GE_Service_Performed_Critical_Spare_Part__c = 'Test',
                            GE_SS_Used__c = 'Yes',
                            GE_SS_How_was_tool_stored__c = 'Basket',
                            GE_SS_Max_Tensile_Load_Applied__c = 1,
                            GE_SS_Max_connection_make_up_Torque__c = 'test',
                            GE_SS_Did_tool_see_any_pressure_Specify__c = 'test',
                            SVMXC__Serial_Number__c = ib.id,
                            SVMXC__Line_Status__c = 'Submitted');
        insert wdl;
        
        Test.setCurrentPageReference(new PageReference('Page.GE_SS_Work_Detail_Line_on_IP'));
        System.currentPageReference().getParameters().put('IP_Id', ib.id);
        GE_SS_Work_Detail_Line_on_IP objCls = new GE_SS_Work_Detail_Line_on_IP();
        
        Test.stopTest();
    }
}