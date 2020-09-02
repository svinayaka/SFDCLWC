@isTest(SeeAllData=true)
private class GE_SS_WorkOrder_Test {
    public testmethod static void testWorkOrder()
    {
        Id csrtid = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-SS').getRecordTypeId();
       
        
        Id wortidMob = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        Id wortidDaily = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Daily').getRecordTypeId();
        Id wortidTrip = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Trip').getRecordTypeId();
       
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
                            RecordTypeId = wortidMob ,
                            SVMXC__Company__c = acc.id,
                            SVMXC__Case__c = cs.id,
                            SVMXC__Order_Status__c = 'Open',
                            GE_SS_No_of_Drilling_Personnel__c = 3); 
        insert svo;
        
        SVMXC__Service_Order__c svo1 = new SVMXC__Service_Order__c(
                            RecordTypeId = wortidDaily ,
                            SVMXC__Company__c = acc.id,
                            SVMXC__Case__c = cs.id,
                            SVMXC__Order_Status__c = 'Open',
                            GE_SS_No_of_Drilling_Personnel__c = 3
                            ); 
        insert svo1;
        
        SVMXC__Service_Order__c svo2 = new SVMXC__Service_Order__c(
                            RecordTypeId = wortidTrip ,
                            SVMXC__Company__c = acc.id,
                            SVMXC__Case__c = cs.id,
                            SVMXC__Order_Status__c = 'Open',
                            GE_SS_No_of_Drilling_Personnel__c = 3); 
        insert svo2;
        
        
        Test.setCurrentPage(Page.GE_SS_Work_Order_Mobilize);
        GE_SS_Work_Order_Mobilize controller1 = new GE_SS_Work_Order_Mobilize(new ApexPages.StandardController(cs));
        
        Test.setCurrentPage(Page.GE_SS_Work_Order_Daily);
        GE_SS_Work_Order_Daily controller2 = new GE_SS_Work_Order_Daily(new ApexPages.StandardController(cs));
        
        Test.setCurrentPage(Page.GE_SS_Work_Order_Trip);
        GE_SS_Work_Order_Trip controller3 = new GE_SS_Work_Order_Trip(new ApexPages.StandardController(cs));
    }
}