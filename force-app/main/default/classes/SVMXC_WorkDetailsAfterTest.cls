@isTest(SeeAllData=true)
private class SVMXC_WorkDetailsAfterTest {

    static testMethod void testWorkDetailsAfter() {
    List<SVMXC__Installed_Product__c> ipList = new List<SVMXC__Installed_Product__c> ();
    List<SVMXC__Service_Order_Line__c> wlList = new List<SVMXC__Service_Order_Line__c> ();
    
        SVMXC__Skill__c skill = new SVMXC__Skill__c(
            Name = 'test',
            GE_PW_PGS_Country__c = 'Test Country',
            GE_PW_PGS_Needs_Visa__c = true,
            GE_PW_PGS_Days_to_Get_Visa__c = 5,
            Business__c = 'PGS',
            Sub_Business__c = 'CS');
        
        insert skill;
        test.StartTest();
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c(SVMXC__Skill__c = skill.Id);
        insert wo;
        
        // insert IP
        SVMXC__Installed_Product__c IP1 = new SVMXC__Installed_Product__c(Name='TsetIP',SVMXC__Status__c = 'Installed',SVMXC__City__c = 'Test', SVMXC__Country__c = 'USA',
                                                                                SVMXC__Installation_Notes__c = 'Test Notes', GE_SS_Quantity__c = 1);
        //insert IP1;
        ipList.add(IP1);
                
        // insert IP2
        SVMXC__Installed_Product__c IP2 = new SVMXC__Installed_Product__c(Name='TsetIP',SVMXC__Status__c = 'Installed',SVMXC__City__c = 'Test', SVMXC__Country__c = 'USA',
                                                                                SVMXC__Installation_Notes__c = 'Test Notes', GE_SS_Quantity__c = 5);
        //insert IP2;
        ipList.add(IP2);
        
        // insert IP3
        SVMXC__Installed_Product__c IP3 = new SVMXC__Installed_Product__c(Name='TsetIP',SVMXC__Status__c = 'Installed',SVMXC__City__c = 'Test', SVMXC__Country__c = 'USA',
                                                                                SVMXC__Installation_Notes__c = 'Test Notes', GE_SS_Quantity__c = 5,
                                                                                GE_SS_Qty_Used__c = 1);
        //insert IP3;
        ipList.add(IP3);
        insert ipList;
        
        Schema.SObjectType s = SVMXC__Service_Order_Line__c.sObjectType;
        Schema.DescribeSObjectResult resSchema = s.getDescribe() ;
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        Id rtSparesId = recordTypeInfo.get('Spares').getRecordTypeId();
        Id rtToolsId = recordTypeInfo.get('Tools').getRecordTypeId();
        
        SVMXC__Service_Order_Line__c sol1 = new SVMXC__Service_Order_Line__c();
        sol1.RecordTypeId = rtSparesId;
        sol1.SVMXC__Serial_Number__c = IP1.Id;
        sol1.SVMXC__Line_Type__c = 'Parts';
        sol1.SVMXC__Service_Order__c = wo.Id;
        sol1.GE_SS_Used__c = 'No';
        
        //insert sol1;
        wlList.add(sol1);
        
        SVMXC__Service_Order_Line__c sol2 = new SVMXC__Service_Order_Line__c();
        sol2.RecordTypeId = rtToolsId;
        sol2.SVMXC__Serial_Number__c = IP2.Id;
        sol2.SVMXC__Line_Type__c = 'Parts';
        sol2.SVMXC__Service_Order__c = wo.Id;
        sol2.GE_SS_Qty_Consumed__c = 3;
        
        //insert sol2;
        wlList.add(sol2);
        
        SVMXC__Service_Order_Line__c sol3 = new SVMXC__Service_Order_Line__c();
        sol3.RecordTypeId = rtSparesId;
        sol3.SVMXC__Serial_Number__c = IP3.Id;
        sol3.SVMXC__Line_Type__c = 'Parts';
        sol3.SVMXC__Service_Order__c = wo.Id;
        sol3.GE_SS_Qty_Consumed__c = 3;
        
        //insert sol3;
        wlList.add(sol3);
        insert wlList;
        test.StopTest();
        sol1.GE_SS_Used__c = 'Yes';
        //update sol1;
        
        sol2.GE_SS_Qty_Consumed__c = 4;
        //update sol2;
        
        SVMXC__Installed_Product__c ipUpdate = [SELECT GE_SS_Qty_Left__c FROM SVMXC__Installed_Product__c WHERE Id =: IP2.Id LIMIT 1];     
        
    }
}