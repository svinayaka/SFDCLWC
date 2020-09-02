@isTest(SeeAllData=false)
private class GE_SS_Update_Trip_onField_Problem_Test {

    public testmethod static void TripFieldProblemMethod()
    {
        
         Id csrtid = Schema.SObjectType.SVMXC__service_order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        id cslrtid = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        Id wdlrtid = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id wortid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Trip').getRecordTypeId();
        
        Account acc = new Account(Name = 'SVMX Test Account');
        insert acc;
        System.assertEquals(acc.Name,'SVMX Test Account');
        
        Product2 prod = new Product2(Name='Test Prod',
                                    ProductCode = '1234');
        insert prod;
    
        SVMXC__Installed_Product__c ib = new SVMXC__Installed_Product__c(
                                    Name = 'TestIB',
                                    SVMXC__Product__c = prod.id,
                                    GE_AL_Installed_Product_Type__c  = 'Tools');
        insert ib;
    
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
    
    SVMXC__service_order__c two = new SVMXC__service_order__c(RecordTypeId = wortid,
                            SVMXC__Order_Status__c = 'New',
                            SVMXC__Component__c = ib.id,        //lookup to IB 
                            SVMXC__Product__c = prod.id,
                            GE_SS_Parent_Work_Order__c = cs.id,
                            GE_SS_No_of_Completions_Personnel__c = 2,
                            GE_SS_No_of_Controls_Personnel__c = 2,
                            GE_SS_Field__c =cs.GE_SS_Field__c );       //lookup to Product
        insert two;
        
        GE_SS_Field_Problem__c recFieldProblem = new GE_SS_Field_Problem__c(
        GE_SS_Mobilize_Work_Order__c = cs.id,
        GE_SS_Work_Order__c = two.id,
        GE_SS_Type_of_Field_Problem__c = 'Minor');
        
        insert recFieldProblem;
    }
public testmethod static void TripFieldProblemMethod1()
    {
        
         Id csrtid = Schema.SObjectType.SVMXC__service_order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        id cslrtid = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        Id wdlrtid = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id wortid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Trip').getRecordTypeId();
        
        Account acc = new Account(Name = 'SVMX Test Account');
        insert acc;
        System.assertEquals(acc.Name,'SVMX Test Account');
        
        Product2 prod = new Product2(Name='Test Prod',
                                    ProductCode = '1234');
        insert prod;
    
        SVMXC__Installed_Product__c ib = new SVMXC__Installed_Product__c(
                                    Name = 'TestIB',
                                    SVMXC__Product__c = prod.id,
                                    GE_AL_Installed_Product_Type__c  = 'Tools');
        insert ib;
    
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
    
    SVMXC__service_order__c two = new SVMXC__service_order__c(RecordTypeId = wortid,
                            SVMXC__Order_Status__c = 'New',
                            SVMXC__Component__c = ib.id,        //lookup to IB 
                            SVMXC__Product__c = prod.id,
                            GE_SS_Parent_Work_Order__c = cs.id,
                            GE_SS_Uptime_Hours__c = 22.0,
                            GE_SS_No_of_Completions_Personnel__c = 2,
                            GE_SS_No_of_Controls_Personnel__c = 2,
                            GE_SS_Field__c = cs.GE_SS_Field__c );       //lookup to Product
        insert two;
        
        GE_SS_Field_Problem__c recFieldProblem = new GE_SS_Field_Problem__c(
        GE_SS_Mobilize_Work_Order__c = cs.id,
        GE_SS_Work_Order__c = two.id,
        GE_SS_Downtime_Recorded_Against_VG__c = 1.00,
        GE_SS_Type_of_Field_Problem__c = 'Minor');
        
        insert recFieldProblem;
    }
    
}