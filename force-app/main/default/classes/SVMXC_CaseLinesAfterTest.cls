@isTest(SeeAllData=true)
private class SVMXC_CaseLinesAfterTest {

    static testMethod void testCaseLinesAfter() {
        
            Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        
        // insert Site
    SVMXC__Site__c loc = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                GE_SS_Project_Region__c = 'LAM',
                                Name = 'Test Field Loc',
                                SVMXC__Latitude__c = 37.662533,
                                SVMXC__Longitude__c = 121.874730,
                                Management_Country__c = 'Aruba');
                        insert loc;
        
        //Case with Location
        Id SSCase =  Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-SS').getRecordTypeId();
    

        Case c = new Case(GE_SS_Field__c = loc.Id,RecordTypeId=SSCase);
        
        insert c;
                
        Schema.SObjectType s = SVMXC__Case_Line__c.sObjectType;
        Schema.DescribeSObjectResult resSchema = s.getDescribe() ;
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        Id rtId = recordTypeInfo.get('Spares').getRecordTypeId();
        
        // insert IP
        SVMXC__Installed_Product__c IP = new SVMXC__Installed_Product__c(Name='TsetIP',SVMXC__Status__c = 'Installed',SVMXC__City__c = 'Test', SVMXC__Country__c = 'USA',
                                                                                SVMXC__Installation_Notes__c = 'Test Notes', GE_SS_Quantity__c = 1);
        insert IP;
        
        Test.startTest();
        
        // insert subsea case lines
        SVMXC__Case_Line__c caseline = new SVMXC__Case_Line__c();
        caseline.RecordTypeId = rtId;
        caseline.GE_SS_Serial_Number__c = IP.Id;
        caseline.SVMXC__Case__c = c.Id;
        caseline.SVMXC__Quantity__c = 2;
        
        insert caseline;
        
        SVMXC__Installed_Product__c updatedIP = [SELECT GE_SS_Quantity__c FROM SVMXC__Installed_Product__c WHERE Id = : IP.Id LIMIT 1];
        
        System.assertEquals(updatedIP.GE_SS_Quantity__c, caseline.SVMXC__Quantity__c);
        
        Test.stopTest();
    }
    // added by sharad
    public testmethod static void testCaseLinesAfter2()
    {
        Id csrtid = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-SS').getRecordTypeId();
        id cslrtid = Schema.SObjectType.SVMXC__Case_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        Id wdlrtid = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id wortid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Daily').getRecordTypeId();
        
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
                                    SVMXC__Product__c = prod.id);
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
                            Case_Line__c = csl.Id,
                            SVMXC__Line_Status__c = 'Submitted');
        insert wdl;

        csl.SVMXC__Quantity__c = 4;
        update csl;
        System.assertEquals(csl.SVMXC__Quantity__c,4);
        
        Test.stopTest();
      
    }
    
    // added by sharad for delete case line
    public testmethod static void testCaseLinesAfter3()
    {
        Id csrtid = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-SS').getRecordTypeId();
        id cslrtid = Schema.SObjectType.SVMXC__Case_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id wdlrtid = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        Id wortid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Daily').getRecordTypeId();
        
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
                                    SVMXC__Product__c = prod.id);
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
                            Case_Line__c = csl.Id,
                            SVMXC__Line_Status__c = 'Submitted');
        insert wdl;

        
        delete csl;
        
        Test.stopTest();
      
    }
    
    // added by sharad for insert case line
    public testmethod static void testCaseLinesAfter4()
    {
        Id csrtid = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-SS').getRecordTypeId();
        id cslrtid = Schema.SObjectType.SVMXC__Case_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id wdlrtid = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        Id wortid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Daily').getRecordTypeId();
        
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
                                    SVMXC__Product__c = prod.id);
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
                            Case_Line__c = csl.Id,
                            SVMXC__Line_Status__c = 'Submitted');
        insert wdl;

        
        SVMXC__Case_Line__c cs5 = new SVMXC__Case_Line__c(
                            RecordTypeId = cslrtid,
                            SVMXC__Case__c = cs.id,                          
                            SVMXC__Quantity__c = 2);
        insert cs5;
        System.assertEquals(cs5.SVMXC__Quantity__c,2);
        
        Test.stopTest();
    }
    
    // added by sharad for insert case line
    public testmethod static void testCaseLinesAfter5()
    {
        Id csrtid = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-SS').getRecordTypeId();
        id cslrtid = Schema.SObjectType.SVMXC__Case_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id wdlrtid = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id wortid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Daily').getRecordTypeId();
        Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        
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
                                    SVMXC__Product__c = prod.id);
        insert ib;
        System.assertEquals(ib.Name,'TestIB');
        
          //Inserting Data into FS Project record
      
          GE_SS_Project__c fsp = new GE_SS_Project__c();
          fsp.Name = 'Test';
          fsp.GE_SS_Account__c = acc.id;
          fsp.GE_SS_Status__c = 'Open';
          //fsp.GE_SS_Project_Region__c = pr.id;
          fsp.GE_SS_Type_of_Customer_Project__c = 'Greenfield';
          fsp.GE_SS_Country__c = 'INDIA';
          insert fsp;
          
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
                            GE_SS_Project__c = fsp.Id,
                            SVMXC__Product__c = prod.id,
                            GE_SS_Field__c = loc.id);       //lookup to Product
        insert cs;
        System.assertEquals(cs.Status,'New');
            
         Test.startTest();
        SVMXC__Case_Line__c csl = new SVMXC__Case_Line__c(
                            RecordTypeId = cslrtid,
                            SVMXC__Case__c = cs.id,   
                            GE_SS_Serial_Number__c = ib.id,
                            SVMXC__Quantity__c = 2);
        insert csl;
        System.assertEquals(csl.SVMXC__Quantity__c,2);
        
        Test.stopTest();
    }
}