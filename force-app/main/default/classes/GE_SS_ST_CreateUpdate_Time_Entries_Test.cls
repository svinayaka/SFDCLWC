@isTest(SeeAllData=true)
private class GE_SS_ST_CreateUpdate_Time_Entries_Test {
 public testmethod static void TestTimeEntries(){
         Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        Id csrtid = Schema.SObjectType.SVMXC__service_order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
      Id Strtid=Schema.SObjectType.SVMXC__Service_Group__c.getRecordTypeInfosByName().get('Technician').getRecordTypeId();
        Id tecrtid=Schema.SObjectType.SVMXC__Service_Group_Members__c.getRecordTypeInfosByName().get('SubSea').getRecordTypeId();
        
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
     GE_SS_Service_Ticket__c svctkt= new GE_SS_Service_Ticket__c();
     svctkt.GE_SS_Account__c=acc.id;
     svctkt.GE_SS_Billable_Type__c='Billable';
     svctkt.GE_SS_Service_Representative__c=tec.id;
     svctkt.GE_SS_Status__c='Complete';
     svctkt.GE_SS_Job_Location__c='Offshore';
     svctkt.GE_SS_Field__c=loc.id;
     svctkt.GE_SS_Service_Start_Date__c=system.today();
       svctkt.GE_SS_Service_Finish_Date__c=system.today()+5;
     svctkt.GE_SS_Product_Category__c='Trees(SSPE)';
     insert svctkt;
     
     GE_SS_Time__c tien=new GE_SS_Time__c(GE_SS_Service_Ticket__c=svctkt.id,GE_SS_Date__c=system.today());
     insert tien;
     
		GE_SS_Time__c tien1=new GE_SS_Time__c(GE_SS_Service_Ticket__c=svctkt.id,GE_SS_Date__c=system.today()+1);
     insert tien1;
     
     GE_SS_Time__c tien2=new GE_SS_Time__c(GE_SS_Service_Ticket__c=svctkt.id,GE_SS_Date__c=system.today()+2);
     insert tien2;
     
         GE_SS_Time__c tien3=new GE_SS_Time__c(GE_SS_Service_Ticket__c=svctkt.id,GE_SS_Date__c=system.today()+3);
     insert tien3;
     
         GE_SS_Time__c tien4=new GE_SS_Time__c(GE_SS_Service_Ticket__c=svctkt.id,GE_SS_Date__c=system.today()+4);
     insert tien4;
     
         GE_SS_Time__c tien5=new GE_SS_Time__c(GE_SS_Service_Ticket__c=svctkt.id,GE_SS_Date__c=system.today()+5);
     insert tien5;
     
      svctkt.GE_SS_Service_Start_Date__c=system.today();
       svctkt.GE_SS_Service_Finish_Date__c=system.today()+3; 
     Update svctkt;
     svctkt.GE_SS_Service_Start_Date__c=system.today()+2;
       svctkt.GE_SS_Service_Finish_Date__c=system.today()+5; 
    Update svctkt;
     
}
}