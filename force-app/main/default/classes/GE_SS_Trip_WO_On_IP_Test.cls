@isTest(SeeAllData=true)
private class GE_SS_Trip_WO_On_IP_Test {

    public testmethod static void testWorkDetailLine()
    {
        Id csrtid = Schema.SObjectType.SVMXC__service_order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        id cslrtid = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
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
                                    GE_AL_Installed_Product_Type__c  = 'Tools',
                                    GE_SS_Used__c='Yes');
        insert ib;
        System.assertEquals(ib.Name,'TestIB');
        
        SVMXC__Site__c loc = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                GE_SS_Project_Region__c = 'LAM',
                                Name = 'Test Field Loc',
                                SVMXC__Latitude__c = 37.662533,
                                SVMXC__Longitude__c = 121.874730,
                                Management_Country__c = 'Aruba');
                        insert loc;
        
        SVMXC__service_order__c cs = new SVMXC__service_order__c(RecordTypeId = csrtid,
                            SVMXC__Order_Status__c = 'New',
                            SVMXC__Component__c = ib.id,        //lookup to IB 
                            SVMXC__Product__c = prod.id,
                            GE_SS_No_of_Completions_Personnel__c = 2,
                            GE_SS_No_of_Controls_Personnel__c = 2,
                            GE_SS_Field__c = loc.id);       //lookup to Product
        insert cs;
        System.assertEquals(cs.SVMXC__Order_Status__c,'New');
        /*   
        SVMXC__Service_Order_Line__c csl = new SVMXC__Service_Order_Line__c(
                            RecordTypeId = cslrtid,
                            SVMXC__Service_Order__c = cs.id,                          
                            SVMXC__Actual_Quantity2__c = 2,
                            GE_SS_Used__c='Yes');
        insert csl;
        System.assertEquals(csl.SVMXC__Actual_Quantity2__c,2);
        */
        SVMXC__Service_Order__c svo = new SVMXC__Service_Order__c(
                            RecordTypeId = wortid,
                            SVMXC__Company__c = acc.id,
                            GE_SS_Parent_Work_Order__c = cs.id,
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
        
        Test.setCurrentPageReference(new PageReference('Page.GE_SS_Trip_WO_On_InstalledProduct'));
        System.currentPageReference().getParameters().put('id', ib.id);
        System.currentPageReference().getParameters().put('allrec', 'true');
    //  System.currentPageReference().getParameters().put('idvalue', cs.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(ib);
        //ApexPages.currentPage().getParameters().put('idvalue',cs.id);
        GE_SS_Trip_WO_On_InstalledProduct objCls = new GE_SS_Trip_WO_On_InstalledProduct(sc);
        objCls.idvalue = svo.id;
        //PageReference pageRef = Page.GE_SS_Mobilize_WO_On_InstalledProduct;
        //pageRef.getParameters().put('idvalue', String.valueOf(cs.Id));
        
        //objCls.idValue = agenda.get(0).Id;
        objCls.deleteWO();
        objCls.tmpID = ib.id;
        //System.currentPageReference().getParameters().put('allrec', 'false');
        objCls.allrec = 'true';
        objCls.editWO();
        objCls.allrec = 'false';
        objCls.editWO();
        //GE_SS_Mobilize_WO_On_InstalledProduct  = new GE_SS_Mobilize_WO_On_InstalledProduct(ApexPages.StandardController);
        
        Test.stopTest();
    }
    
    
    
     public testmethod static void testWorkDetailLine1()
    {
        Id csrtid = Schema.SObjectType.SVMXC__service_order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        id cslrtid = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
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
        
        SVMXC__service_order__c cs = new SVMXC__service_order__c(RecordTypeId = csrtid,
                            SVMXC__Order_Status__c = 'New',
                            SVMXC__Component__c = ib.id,        //lookup to IB 
                            SVMXC__Product__c = prod.id,
                            GE_SS_No_of_Completions_Personnel__c = 2,
                            GE_SS_No_of_Controls_Personnel__c = 2,
                            GE_SS_Field__c = loc.id);       //lookup to Product
        insert cs;
        System.assertEquals(cs.SVMXC__Order_Status__c,'New');
        /*
        SVMXC__Service_Order_Line__c csl = new SVMXC__Service_Order_Line__c(
                            RecordTypeId = cslrtid,
                            SVMXC__Service_Order__c = cs.id,                          
                            SVMXC__Actual_Quantity2__c = 2);
        insert csl;
        System.assertEquals(csl.SVMXC__Actual_Quantity2__c,2);
        */
        SVMXC__Service_Order__c svo = new SVMXC__Service_Order__c(
                            RecordTypeId = wortid,
                            SVMXC__Company__c = acc.id,
                            GE_SS_Parent_Work_Order__c = cs.id,
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
        
        Test.setCurrentPageReference(new PageReference('Page.GE_SS_Trip_WO_On_InstalledProduct'));
        System.currentPageReference().getParameters().put('id', ib.id);
        System.currentPageReference().getParameters().put('allrec', 'false');
    //  System.currentPageReference().getParameters().put('idvalue', cs.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(ib);
        //ApexPages.currentPage().getParameters().put('idvalue',svo.id);
        GE_SS_Trip_WO_On_InstalledProduct objCls = new GE_SS_Trip_WO_On_InstalledProduct(sc);
        objCls.idvalue = svo.id;
        //PageReference pageRef = Page.GE_SS_Mobilize_WO_On_InstalledProduct;
        //pageRef.getParameters().put('idvalue', String.valueOf(cs.Id));
        
        //objCls.idValue = agenda.get(0).Id;
        objCls.deleteWO();
        objCls.tmpID = ib.id;
        //System.currentPageReference().getParameters().put('allrec', 'false');
        //objCls.allrec = 'true';
        objCls.editWO();
        //objCls.allrec = 'false';
        //objCls.editWO();
        //GE_SS_Mobilize_WO_On_InstalledProduct  = new GE_SS_Trip_WO_On_InstalledProduct(ApexPages.StandardController);
        
        Test.stopTest();
    }

}