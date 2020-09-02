@istest(SeeAllData=TRUE)
public class GE_OG_HQ_WO_SetEndDateTime_Test {
    public static testMethod void testAllDayEvent(){
        Database.SaveResult dbsave;
        Database.DeleteResult dbdel;
        //Id csrtid = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-SS').getRecordTypeId();
       
        
        Id wortid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
       
        Id UserId = UserInfo.getUserId();
        Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        Id acc1RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
            
       // Account acc = new Account(Name = 'SVMX Test Account', Classification__c = 'Strategic', Type ='Partner');
          Account accLE= new Account(Name = 'Test Account',RecordTypeId=acc1RecordTypeId ,Classification__c='Key Acccount',
            Type='Direct Customer',Account_Tier_GEOG__c='Global');
           insert accLE;
        Account acc = new Account(Name ='TestAccount Legal',
            RecordTypeId=accRecordTypeId ,
            Account_Status__c='CC Approved',
            Account_Tier_GEOG__c='LE',
            Classification__c='Key Acccount',
            Type='Direct Customer',
            Member_of_GE_OG__c=accLE.Id);
            insert acc;
        
       // dbsave = database.insert(acc);
        
        SVMXC__Service_Group__c sg = new SVMXC__Service_Group__c( 
                                        Name = 'TestST',
                                        SVMXC__Country__c = 'United States',
                                        SVMXC__Active__c = true);
        //insert sg; 
        dbsave = database.insert(sg);
       
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
                                        Name = 'Test Tech',
                                        SVMXC__Service_Group__c = sg.id,                                      
                                        SVMXC__Enable_Scheduling__c = true,
                                        SVMXC__Active__c = true,
                                        SVMXC__Email__c = 'abc@xzy.com',
                                        SVMXC__Salesforce_User__c = UserInfo.getUserId());
 
        dbsave = database.insert(tech);
        
        SVMXC__Service_Order__c svo = new SVMXC__Service_Order__c(
                            RecordTypeId = wortid ,
                            SVMXC__Company__c = acc.id,
                            SVMXC__Order_Status__c = 'Open',
                            SVMXC__Scheduled_Date_Time__c = Date.newInstance(2015, 1, 3),
                            SVMXC__Service_Duration__c  =86400, GE_SS_No_of_Completions_Personnel__c =2);
                            //GE_SS_No_of_Drilling_Personnel__c = 3); 

        // insert svo;
        dbsave = database.insert(svo);
        
        test.startTest();
        
        SVMXC__SVMX_Event__c SMXev = new SVMXC__SVMX_Event__c(
                            SVMXC__Technician__c = tech.Id,
                            Name = 'TestEvent',
                            SVMXC__StartDateTime__c = System.now(),
                            SVMXC__EndDateTime__c = System.now().addDays(1),
                            SVMXC__WhatId__c = svo.id,
                            Work_Order__c = svo.id,
                            SVMXC__Service_Order__c = svo.id,
                            SVMXC__IsAllDayEvent__c = TRUE);
        
        //insert SMXev;
        dbsave = database.insert(SMXev);
        
        // Assert statements should be checking the WO end date time field and duration based on insert
        SVMXC__Service_Order__c svo2 = [select id, GE_SM_HQ_Scheduled_End_Date_Time__c, SVMXC__Scheduled_Date_Time__c, SVMXC__Service_Duration__c from SVMXC__Service_Order__c  where id =: svo.id];
        system.assertEquals(svo2.GE_SM_HQ_Scheduled_End_Date_Time__c, svo2.SVMXC__Scheduled_Date_Time__c.addSeconds(Integer.valueOf(svo.SVMXC__Service_Duration__c)-1));
        
        SMXev.SVMXC__EndDateTime__c = System.now().addDays(2);
        //update SMXev;
        dbsave = database.update(SMXev);
        
        // Assert statements should be checking the WO end date time field and duration based on Update
        SVMXC__Service_Order__c svo3 = [select id, GE_SM_HQ_Scheduled_End_Date_Time__c, SVMXC__Scheduled_Date_Time__c, SVMXC__Service_Duration__c from SVMXC__Service_Order__c  where id =: svo.id];
        system.assertEquals(svo3.GE_SM_HQ_Scheduled_End_Date_Time__c, svo3.SVMXC__Scheduled_Date_Time__c.addSeconds(Integer.valueOf(svo.SVMXC__Service_Duration__c)-1));
        
        //delete SMXev;
        dbdel = database.delete(SMXev);
        
        // Assert statements should be checking the WO end date time field and duration based on Delete (should be null in end date time field )
        SVMXC__Service_Order__c svo4 = [select id, GE_SM_HQ_Scheduled_End_Date_Time__c from SVMXC__Service_Order__c  where id =: svo.id];
        system.assertEquals(svo4.GE_SM_HQ_Scheduled_End_Date_Time__c, null);
        
        test.stopTest();
                       
    }
    
    public static testMethod void testNonAllDayEvent(){
        Database.SaveResult dbsave;
        Database.DeleteResult dbdel;
        //Id csrtid = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-SS').getRecordTypeId();
        
        Id wortid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
       
        Id UserId = UserInfo.getUserId();
            
        //Account acc = new Account(Name = 'SVMX Test Account', Classification__c = 'Strategic' , Type ='Partner');
        Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        Id acc1RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
         Account accLE= new Account(Name = 'Test Account',RecordTypeId=acc1RecordTypeId ,Classification__c='Key Acccount',
            Type='Direct Customer',Account_Tier_GEOG__c='Global');
           insert accLE;    
       // Account acc = new Account(Name = 'SVMX Test Account', Classification__c = 'Strategic', Type ='Partner');
        Account acc = new Account(Name ='TestAccount Legal',
            RecordTypeId=accRecordTypeId ,
            Account_Status__c='CC Approved',
            Account_Tier_GEOG__c='LE',
            Classification__c='Key Acccount',
            Type='Direct Customer',
            Member_of_GE_OG__c=accLE.Id);
            insert acc;
        
        //dbsave = database.insert(acc);

                SVMXC__Service_Group__c sg = new SVMXC__Service_Group__c( 
                                        Name = 'TestST',
                                        SVMXC__Country__c = 'United States',
                                        SVMXC__Active__c = true);

        //insert sg; 
        dbsave = database.insert(sg);
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
                                        Name = 'Test Tech',
                                        SVMXC__Service_Group__c = sg.id,                                      
                                        SVMXC__Enable_Scheduling__c = true,
                                        SVMXC__Active__c = true,
                                        SVMXC__Email__c = 'abc@xzy.com',
                                        SVMXC__Salesforce_User__c = UserInfo.getUserId());
 
        dbsave = database.insert(tech);
        
        SVMXC__Service_Order__c svo = new SVMXC__Service_Order__c(
                            RecordTypeId = wortid ,
                            SVMXC__Company__c = acc.id,
                            SVMXC__Order_Status__c = 'Open',
                            SVMXC__Scheduled_Date_Time__c = Date.newInstance(2015, 1, 3),
                            SVMXC__Service_Duration__c  =86400, GE_SS_No_of_Completions_Personnel__c = 2);
                            //GE_SS_No_of_Drilling_Personnel__c = 3); 

//        insert svo;
        dbsave = database.insert(svo);
        
        test.startTest();
       
        // running test against all day event = false
        SVMXC__SVMX_Event__c SMXev2 = new SVMXC__SVMX_Event__c(
                            SVMXC__Technician__c = tech.Id,
                            Name = 'TestEvent',
                            SVMXC__StartDateTime__c = System.now(),
                            SVMXC__EndDateTime__c = System.now().addDays(1),
                            SVMXC__WhatId__c = svo.id,
                            Work_Order__c = svo.id,
                            SVMXC__Service_Order__c = svo.id,
                            SVMXC__IsAllDayEvent__c = FALSE);
        dbsave = database.insert(SMXev2);
        
        // Assert statements should be checking the WO end date time field and duration based on insert
        SVMXC__Service_Order__c svo2 = [select id, GE_SM_HQ_Scheduled_End_Date_Time__c, SVMXC__Scheduled_Date_Time__c, SVMXC__Service_Duration__c from SVMXC__Service_Order__c  where id =: svo.id];
        system.assertEquals(svo2.GE_SM_HQ_Scheduled_End_Date_Time__c, svo2.SVMXC__Scheduled_Date_Time__c.addSeconds(Integer.valueOf(svo.SVMXC__Service_Duration__c)));
        
        SMXev2.SVMXC__EndDateTime__c = System.now().addDays(2);
        //update SMXev;
        dbsave = database.update(SMXev2);
        
        // Assert statements should be checking the WO end date time field and duration based on update
        SVMXC__Service_Order__c svo3 = [select id, GE_SM_HQ_Scheduled_End_Date_Time__c, SVMXC__Scheduled_Date_Time__c, SVMXC__Service_Duration__c from SVMXC__Service_Order__c  where id =: svo.id];
        system.assertEquals(svo3.GE_SM_HQ_Scheduled_End_Date_Time__c, svo3.SVMXC__Scheduled_Date_Time__c.addSeconds(Integer.valueOf(svo.SVMXC__Service_Duration__c)));

        //delete SMXev;
        dbdel = database.delete(SMXev2);

        // Assert statements should be checking the WO end date time field and duration based on Delete (should be null in end date time field )
        SVMXC__Service_Order__c svo4 = [select id, GE_SM_HQ_Scheduled_End_Date_Time__c, SVMXC__Scheduled_Date_Time__c, SVMXC__Service_Duration__c from SVMXC__Service_Order__c  where id =: svo.id];
        system.assertEquals(svo4.GE_SM_HQ_Scheduled_End_Date_Time__c, null);

        //System.assertEquals(dbdel.issuccess(), true);
        test.stopTest();       
    }
}