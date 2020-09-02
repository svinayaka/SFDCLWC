@isTest(SeeAllData=true)
private class GE_SS_CloseWorkOrderChilds_Test {

    public testmethod static void TestCloseWorkOrderChilds()
    {
        Id csrtid = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-SS').getRecordTypeId();
        id cslrtid = Schema.SObjectType.SVMXC__Case_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id wdlrtid = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        Id wortidMob = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        Id wortid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Trip').getRecordTypeId();
        
        Id UserId = UserInfo.getUserId();
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
                            RecordTypeId = wortidMob,
                            SVMXC__Company__c = acc.id,
                            SVMXC__Case__c = cs.id,
                            SVMXC__Order_Status__c = 'Opened',
                            SVMXC__Country__c  = 'United States',
                            GE_SS_No_of_Drilling_Personnel__c = 3);
        insert svo;
        System.assertEquals(svo.SVMXC__Order_Status__c,'Opened');
        
        SVMXC__Service_Order__c svoChild = new SVMXC__Service_Order__c(
                            RecordTypeId = wortid,
                            SVMXC__Company__c = acc.id,
                            GE_SS_Parent_Work_Order__c = svo.Id,
                            SVMXC__Case__c = cs.id,
                            SVMXC__Order_Status__c = 'Opened',
                            SVMXC__Country__c  = 'United States',
                            GE_SS_No_of_Drilling_Personnel__c = 3);
        insert svoChild;
        System.assertEquals(svoChild.SVMXC__Order_Status__c,'Opened');
        
    
        Test.startTest();
   
        SVMXC__Service_Order_Line__c wdl = new SVMXC__Service_Order_Line__c(
                            RecordTypeId = wdlrtid,
                            SVMXC__Service_Order__c = svo.id,
                            Case_Line__c = csl.Id,
                            SVMXC__Serial_Number__c = ib.id,
                            SVMXC__Line_Status__c = 'Submitted');
        insert wdl;
        
        svo.SVMXC__Order_Status__c = 'Ready for Invoicing';
        update svo;
        
        Test.stopTest();
    }
}