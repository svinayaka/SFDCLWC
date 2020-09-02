@IsTest
public class GE_OG_MC_EventDateChanges_Test {

public static testmethod void GE_OG_MC_EventDateChangesMethod(){
  
  ID Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
  
               
               List<SVMXC__SVMX_Event__c>  eventSvmx= new List<SVMXC__SVMX_Event__c >();
               List<SVMXC__Service_Order__c> woList = new List<SVMXC__Service_Order__c>();
               
               SVMXC__Skill__c skill=new SVMXC__Skill__c();
               skill.Name='Test';
               insert skill;
               System.assertEquals(skill.Name,'Test');
                           
               SVMXC__Service_Order__c  wo = new SVMXC__Service_Order__c ();
               wo.GE_SM_HQ_Scheduled_Start_Date_Time__c=system.TODAY();
               wo.GE_SM_HQ_Scheduled_End_Date_Time__c =system.TODAY()+1;
               wo.GE_OG_MC_Service_Region__c='Europe';
               wo.GE_OG_MC_Business_Unit__c='CS';
               wo.RecordTypeId=Rectype;
               wo.SVMXC__Skill__c= skill.id;
             //  wo.SVMXC__Group_Member__c = Technician.id;
              // wo.SVMXC__Service_Group__c = serviceTeam.id;
              woList.add(wo);
              
              SVMXC__Service_Order__c  wo1 = new SVMXC__Service_Order__c ();
               wo1.GE_SM_HQ_Scheduled_Start_Date_Time__c=system.TODAY();
               wo1.GE_SM_HQ_Scheduled_End_Date_Time__c =system.TODAY()+1;
               wo1.GE_OG_MC_Service_Region__c='Europe';
               wo1.GE_OG_MC_Business_Unit__c='CS';
               wo1.RecordTypeId=Rectype;
               wo1.SVMXC__Skill__c= skill.id;
               woList.add(wo1);
               
               insert woList; 
   
               SVMXC__SVMX_Event__c event1 = new SVMXC__SVMX_Event__c();
               event1.Name='test_raj1';
               event1.SVMXC__IsAllDayEvent__c = false;
               event1.SVMXC__StartDateTime__c=Date.newInstance(2015, 1, 3);
               event1.SVMXC__EndDateTime__c=Date.newInstance(2015, 1, 4);
               event1.SVMXC_Start_Date_Time_UI__c = Date.newInstance(2015, 1, 8);
               event1.SVMXC_End_Date_Time_UI__c = Date.newInstance(2015, 1, 10);
              // event1.SVMXC__Service_Team__c = serviceTeam.id;
              // event1.SVMXC__Technician__c = Technician.id;
               event1.SVMXC__Service_Order__c = wo.id;
               eventSvmx.add(event1);
              // insert event1;
               
               SVMXC__SVMX_Event__c event2 = new SVMXC__SVMX_Event__c();
               event2.Name='test_raj2';
               event2.SVMXC__IsAllDayEvent__c = false;
               event2.SVMXC__StartDateTime__c=Date.newInstance(2015, 1, 3);
               event2.SVMXC__EndDateTime__c=Date.newInstance(2015, 1, 4);
               event2.SVMXC_Start_Date_Time_UI__c = Date.newInstance(2015, 1, 11);
               event2.SVMXC_End_Date_Time_UI__c = Date.newInstance(2015, 1, 12);
             //  event2.SVMXC__Service_Team__c = serviceTeam.id;
             //  event2.SVMXC__Technician__c = Technician.id;
               event2.SVMXC__Service_Order__c = wo1.id;
               eventSvmx.add(event2);
              insert eventSvmx;
             
             
                event2.SVMXC_Start_Date_Time_UI__c = Date.newInstance(2015, 1, 12);
                event2.SVMXC_End_Date_Time_UI__c = Date.newInstance(2016, 1, 13);
                event2.SVMXC__Service_Order__c = wo1.id;
                
                event1.SVMXC_Start_Date_Time_UI__c = Date.newInstance(2015, 1, 12);
                event1.SVMXC_End_Date_Time_UI__c = Date.newInstance(2016, 1, 13);
                event1.SVMXC__Service_Order__c = wo.id;
                update eventSvmx; 
                 
                 
                
                 GE_OG_MC_EventDateChanges  evntDateChange=new GE_OG_MC_EventDateChanges();
                 evntDateChange.eventDatesExtraction(eventSvmx);
                 
 }
 
 
 
 
  public static testmethod void GE_OG_MC_EventDateDeleteMethod(){                
                 ID Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
  
               
               List<SVMXC__SVMX_Event__c>  eventSvmx= new List<SVMXC__SVMX_Event__c >();
               List<SVMXC__Service_Order__c> woList = new List<SVMXC__Service_Order__c>();
               
               SVMXC__Skill__c skill=new SVMXC__Skill__c();
               skill.Name='Test';
               insert skill;
               System.assertEquals(skill.Name,'Test');
                           
               SVMXC__Service_Order__c  wo = new SVMXC__Service_Order__c ();
               wo.GE_SM_HQ_Scheduled_Start_Date_Time__c=system.TODAY();
               wo.GE_SM_HQ_Scheduled_End_Date_Time__c =system.TODAY()+1;
               wo.GE_OG_MC_Service_Region__c='Europe';
               wo.GE_OG_MC_Business_Unit__c='CS';
               wo.RecordTypeId=Rectype;
               wo.SVMXC__Skill__c= skill.id;
             //  wo.SVMXC__Group_Member__c = Technician.id;
              // wo.SVMXC__Service_Group__c = serviceTeam.id;
              woList.add(wo);
              
              SVMXC__Service_Order__c  wo1 = new SVMXC__Service_Order__c ();
               wo1.GE_SM_HQ_Scheduled_Start_Date_Time__c=system.TODAY();
               wo1.GE_SM_HQ_Scheduled_End_Date_Time__c =system.TODAY()+1;
               wo1.GE_OG_MC_Service_Region__c='Europe';
               wo1.GE_OG_MC_Business_Unit__c='CS';
               wo1.RecordTypeId=Rectype;
               wo1.SVMXC__Skill__c= skill.id;
               woList.add(wo1);
               
               insert woList; 
   
               SVMXC__SVMX_Event__c event1 = new SVMXC__SVMX_Event__c();
               event1.Name='test_raj1';
               event1.SVMXC__IsAllDayEvent__c = false;
               event1.SVMXC__StartDateTime__c=Date.newInstance(2015, 1, 3);
               event1.SVMXC__EndDateTime__c=Date.newInstance(2015, 1, 4);
               event1.SVMXC_Start_Date_Time_UI__c = Date.newInstance(2015, 1, 8);
               event1.SVMXC_End_Date_Time_UI__c = Date.newInstance(2015, 1, 10);
              // event1.SVMXC__Service_Team__c = serviceTeam.id;
              // event1.SVMXC__Technician__c = Technician.id;
               event1.SVMXC__Service_Order__c = wo.id;
               eventSvmx.add(event1);
              // insert event1;
               
              SVMXC__SVMX_Event__c event2 = new SVMXC__SVMX_Event__c();
               event2.Name='test_raj2';
               event2.SVMXC__IsAllDayEvent__c = false;
               event2.SVMXC__StartDateTime__c=Date.newInstance(2015, 1, 3);
               event2.SVMXC__EndDateTime__c=Date.newInstance(2015, 1, 4);
               event2.SVMXC_Start_Date_Time_UI__c = Date.newInstance(2015, 1, 11);
               event2.SVMXC_End_Date_Time_UI__c = Date.newInstance(2015, 1, 12);
             //  event2.SVMXC__Service_Team__c = serviceTeam.id;
             //  event2.SVMXC__Technician__c = Technician.id;
               event2.SVMXC__Service_Order__c = wo1.id;
               eventSvmx.add(event2);
              insert eventSvmx;
              
              System.assertEquals(event2.SVMXC_End_Date_Time_UI__c,Date.newInstance(2015, 1, 12));
              
              GE_OG_MC_EventDateChanges  evntDateChange=new GE_OG_MC_EventDateChanges();
                                  
                 evntDateChange.eventDatesDeletion(eventSvmx);
             
                 
 }
 
 }