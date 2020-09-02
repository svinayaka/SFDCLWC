@isTest(SeeAllData=true)
private class GE_SS_Mobilize_WO_On_Technician_Test {
    public testmethod static void testTechnicianWO(){
         Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        Id csrtid = Schema.SObjectType.SVMXC__service_order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        Id tecrtid=Schema.SObjectType.SVMXC__Service_Group_Members__c.getRecordTypeInfosByName().get('SubSea').getRecordTypeId();
        Id Strtid=Schema.SObjectType.SVMXC__Service_Group__c.getRecordTypeInfosByName().get('Technician').getRecordTypeId();
        Id wortid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Trip').getRecordTypeId();
     Id UserId = UserInfo.getUserId();
        //String useremail = UserInfo.getUserEmail();
        User u = [SELECT UserName,Email FROM User where Id =: UserId]; 
            
        Account acc = new Account(Name = 'SVMX Test Account');
        insert acc;
        System.assertEquals(acc.Name,'SVMX Test Account');
        
       
        
        SVMXC__Site__c loc = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                GE_SS_Project_Region__c = 'LAM',
                                Name = 'Test Field Loc',
                                SVMXC__Latitude__c = 37.662533,
                                SVMXC__Longitude__c = 121.874730,
                                Management_Country__c = 'Aruba');
                        insert loc;
   SVMXC__Service_Group__c st= new SVMXC__Service_Group__c(RecordTypeId = strtid,Name='Test Service Team',
                                                           GE_OG_GS_Service_Team_Type__c='Regional',
                                                          GE_HQ_P_L_Level__c='O&G > SS'); 
SVMXC__Service_Group_Members__c tec=new SVMXC__Service_Group_Members__c(RecordTypeId =tecrtid,
                                                                        SVMXC__Service_Group__c=st.id,
                                                                        Name='Test Technician',
                                                                        SVMXC__Salesforce_User__c=u.id,
                                                                        GE_DS_Career_Track_Level__c='Entry',
                                                                        Management_Country__c='Aruba',GE_SM_HQ_SSO_ID__c='12345678');
        SVMXC__service_order__c cs = new SVMXC__service_order__c(RecordTypeId = csrtid,
                            SVMXC__Order_Status__c = 'New',
                            GE_SS_No_of_Completions_Personnel__c = 2,
                            GE_SS_No_of_Controls_Personnel__c = 2,
                            GE_SS_Field__c = loc.id);       //lookup to Product
        insert cs;
        System.assertEquals(cs.SVMXC__Order_Status__c,'New');
        
        SVMXC__service_order__c cs1 = new SVMXC__service_order__c(RecordTypeId = csrtid,
                            SVMXC__Order_Status__c = 'New',
                            GE_SS_No_of_Completions_Personnel__c = 5,
                            GE_SS_No_of_Controls_Personnel__c = 5,
                            GE_SS_Field__c = loc.id);  
        insert cs1;
        
 Test.startTest();        
       SVMXC__SVMX_Event__c se= new SVMXC__SVMX_Event__c(Name='WO-00406451',
                                                         SVMXC__Technician__c=tec.id);
                                                         
Test.setCurrentPageReference(new PageReference('Page.GE_SS_Mobilize_WO_on_Technician'));
      System.currentPageReference().getParameters().put('id', tec.id);
        System.currentPageReference().getParameters().put('allrec', 'true');
    ApexPages.StandardController sc = new ApexPages.StandardController(tec);
        GE_SS_Mobilize_WO_on_Technician objCls = new GE_SS_Mobilize_WO_on_Technician(sc);
          objCls.idvalue = cs1.id;
         objCls.deleteWO();
        objCls.tmpID = tec.id;
        objCls.allrec = 'true';
         objCls.editWO();
        objCls.allrec = 'false';
        objCls.editWO();
        
          Test.stopTest();
    }
    public testmethod static void testTechnicianWO1(){
         Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        Id csrtid = Schema.SObjectType.SVMXC__service_order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        Id tecrtid=Schema.SObjectType.SVMXC__Service_Group_Members__c.getRecordTypeInfosByName().get('SubSea').getRecordTypeId();
        Id Strtid=Schema.SObjectType.SVMXC__Service_Group__c.getRecordTypeInfosByName().get('Technician').getRecordTypeId();
       Id wortid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Trip').getRecordTypeId();
     Id UserId = UserInfo.getUserId();
        //String useremail = UserInfo.getUserEmail();
        User u = [SELECT UserName,Email FROM User where Id =: UserId]; 
            
        Account acc = new Account(Name = 'SVMX Test Account');
        insert acc;
        System.assertEquals(acc.Name,'SVMX Test Account');
        
       
        
        SVMXC__Site__c loc = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                GE_SS_Project_Region__c = 'LAM',
                                Name = 'Test Field Loc',
                                SVMXC__Latitude__c = 37.662533,
                                SVMXC__Longitude__c = 121.874730,
                                Management_Country__c = 'Aruba');
                        insert loc;
   SVMXC__Service_Group__c st= new SVMXC__Service_Group__c(RecordTypeId = strtid,Name='Test Service Team',
                                                           GE_OG_GS_Service_Team_Type__c='Regional',
                                                          GE_HQ_P_L_Level__c='O&G > SS'); 
SVMXC__Service_Group_Members__c tec=new SVMXC__Service_Group_Members__c(RecordTypeId =tecrtid,
                                                                        SVMXC__Service_Group__c=st.id,
                                                                        Name='Test Technician',
                                                                        SVMXC__Salesforce_User__c=u.id,
                                                                        GE_DS_Career_Track_Level__c='Entry',
                                                                        Management_Country__c='Aruba',GE_SM_HQ_SSO_ID__c='12345678');
        SVMXC__service_order__c cs = new SVMXC__service_order__c(RecordTypeId = csrtid,
                            SVMXC__Order_Status__c = 'New',
                             GE_SS_Billable_Type__c='Billable',
                             GE_SS_Job_Location__c='Offshore',
                             SVMXC__Company__c=acc.id,
                             GE_SS_Product_Category__c='Wellheads(SSWE)',
                             GE_SS_Job_Type_New__c='Contract',
                             GE_SS_Planned_Mobilization_date_of_FSE__c = system.today(),
                               GE_SS_Planned_Demobilization_date_of_FSE__c=system.today()+5,                                   
                            GE_SS_No_of_Completions_Personnel__c = 2,
                            GE_SS_No_of_Controls_Personnel__c = 2,
                            GE_SS_Field__c = loc.id);       //lookup to Product
        insert cs;
        System.assertEquals(cs.SVMXC__Order_Status__c,'New');
        
        SVMXC__service_order__c cs1 = new SVMXC__service_order__c(RecordTypeId = csrtid,
                            SVMXC__Order_Status__c = 'New',
                            GE_SS_No_of_Completions_Personnel__c = 5,
                            GE_SS_No_of_Controls_Personnel__c = 5,
                            GE_SS_Field__c = loc.id);  
        insert cs1;
        
         SVMXC__Service_Order__c svo = new SVMXC__Service_Order__c(
                            RecordTypeId = wortid,
                            SVMXC__Company__c = acc.id,
                            GE_SS_Parent_Work_Order__c = cs.id,
                            SVMXC__Order_Status__c = 'Opened',
                            SVMXC__Country__c  = 'United States');
        insert svo;

        
 Test.startTest();        
       SVMXC__SVMX_Event__c se= new SVMXC__SVMX_Event__c(Name='WO-00406451',
                                                         SVMXC__Technician__c=tec.id,
                                                        SVMXC__Service_Order__c=cs.id);
        SVMXC__SVMX_Event__c se1= new SVMXC__SVMX_Event__c(Name='WO-00422261',
                                                         SVMXC__Technician__c=tec.id,
                                                          SVMXC__Service_Order__c=cs1.id);
        SVMXC__SVMX_Event__c se2= new SVMXC__SVMX_Event__c(Name='WO-00436457',
                                                         SVMXC__Technician__c=tec.id,
                                                          SVMXC__Service_Order__c=svo.id);
                                                         
Test.setCurrentPageReference(new PageReference('Page.GE_SS_Mobilize_WO_on_Technician'));
      System.currentPageReference().getParameters().put('id', tec.id);
        System.currentPageReference().getParameters().put('allrec', 'false');
    ApexPages.StandardController sc = new ApexPages.StandardController(tec);
        GE_SS_Mobilize_WO_on_Technician objCls = new GE_SS_Mobilize_WO_on_Technician(sc);
          objCls.idvalue = cs1.id;
         objCls.deleteWO();
        objCls.editWO();
        objCls.tmpID = tec.id;
          Test.stopTest();
    }
}